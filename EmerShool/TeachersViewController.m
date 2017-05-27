//
//  TeachersViewController.m
//  EmerShool
//
//  Created by Gbir on 27.05.17.
//  Copyright © 2017 EmerShool. All rights reserved.
//

#import "TeachersViewController.h"
#import "TeacherCell.h"
#import "TeachersListOp.h"
#import "AuthorisationHandler.h"

NSString * const kTeacherCellReuseId = @"teacherCellReuseId";
CGFloat const kAddTeacherToolbarOffset = 44.0f;

@interface TeachersViewController () {
}

@property (strong, nonatomic) NSMutableArray <NSDictionary *> * serverData;

@end

@implementation TeachersViewController

#pragma mark - dataload
- (void)reloadDataWithCompletion:(ReloadCompletionHandler)completion {
    [self loadServerDataCompletion:^(NSError * _Nullable error, NSArray<NSDictionary *> * _Nullable teachersList) {
        completion(nil, nil);
    }];
}


- (void)loadServerDataCompletion:(TeachersListCompletionHandler)completion {
    __weak TeachersViewController *this = self;
    TeachersListOp *teachersListOp = [[TeachersListOp alloc] initWithCompletion:^(NSError * _Nullable error, NSArray<NSDictionary *> * _Nullable teachersList) {
        if (teachersList && teachersList.count)
            this.serverData = [[NSMutableArray alloc]initWithArray:teachersList];
        else
            [this.serverData removeAllObjects];
        if (completion)
            completion(error,teachersList);
        
    } token:self.authHandler.token];
    [self.defaultQueue addOperation:teachersListOp];
}

- (void)loadData {
    [super loadData];
    NSMutableArray *listItems = [[NSMutableArray alloc] initWithCapacity:self.serverData.count];
    
    for (NSDictionary *item in self.serverData) {
        
        CellMetaData *cellData = [CellMetaData new];
        cellData.titleCell = item[@"fio"];
        cellData.subTitleCell = item[@"subject"];
        cellData.reusIdCell = kTeacherCellReuseId;
        cellData.bollValue = [item[@"isAccepted"] boolValue];
        cellData.scoreValue = item[@"score"];
        cellData.rateValue = item[@"rate"];
        [listItems addObject:cellData];
    }
    
    [self.sections addObject:listItems];
}
#pragma mark -

- (void)viewDidLoad {
    self.serverData = [NSMutableArray array];
    [super viewDidLoad];
    [self registerCellWithClass:[TeacherCell class] reusId:kTeacherCellReuseId];
    [self loadServerDataCompletion:^(NSError * _Nullable error, NSArray<NSDictionary *> * _Nullable teachersList) {
        [self reloadData];
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.addTeacherToolbarTopConstraint.constant = 0;
    [self.tableView.superview sendSubviewToBack:self.tableView];
}

- (void)processPreparedCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath  {
    NSArray *row = self.sections[indexPath.section];
    CellMetaData *cellData = row[indexPath.row];
    ((TeacherCell *)cell).cellTitleLabel.text = cellData.titleCell;
    ((TeacherCell *)cell).cellSubtitleLabel.text = cellData.subTitleCell;
    UIImage *image =  [UIImage imageNamed:cellData.bollValue ? @"Mark" : @"Delete"];
    ((TeacherCell *)cell).leftIconImageView.image = image;
    ((TeacherCell *)cell).ratingLabelCell.text = cellData.rateValue;
    ((TeacherCell *)cell).teacherWeightLabel.text = cellData.scoreValue;
}

- (IBAction)addTeacherTogglerButtonPressed:(id)sender {
    self.addTeacherToolbarTopConstraint.constant = self.addTeacherToolbarTopConstraint.constant > 0 ? 0 : kAddTeacherToolbarOffset;
    [self.view setNeedsLayout];
    
    [self.view endEditing:YES];
    
//    [UIView animateWithDuration:2 animations:^{
//        [self.view setNeedsLayout];
//    }];
}
@end
