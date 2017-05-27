//
//  TeachersViewController.m
//  EmerShool
//
//  Created by Gbir on 27.05.17.
//  Copyright © 2017 EmerShool. All rights reserved.
//

#import "TeachersViewController.h"
#import "TeacherCell.h"

NSString * const kTeacherCellReuseId = @"teacherCellReuseId";
CGFloat const kAddTeacherToolbarOffset = 44.0f;

@interface TeachersViewController () {
}


@end

@implementation TeachersViewController
#pragma mark - dataload
- (void)reloadDataWithCompletion:(ReloadCompletionHandler)completion {
    completion(nil, nil);    
}

- (void)loadData {
    [super loadData];
    CellMetaData *cellData = [CellMetaData new];
    cellData.titleCell = @"test";
    cellData.reusIdCell = kTeacherCellReuseId;
    [self.sections addObject:@[cellData]];
}
#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCellWithClass:[TeacherCell class] reusId:kTeacherCellReuseId];
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
}

- (IBAction)addTeacherTogglerButtonPressed:(id)sender {
    self.addTeacherToolbarTopConstraint.constant = self.addTeacherToolbarTopConstraint.constant > 0 ? 0 : kAddTeacherToolbarOffset;
    [self.view setNeedsLayout];
    
//    [UIView animateWithDuration:2 animations:^{
//        [self.view setNeedsLayout];
//    }];
}
@end
