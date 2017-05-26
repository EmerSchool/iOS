//
//  TeachersViewController.m
//  EmerShool
//
//  Created by Gbir on 27.05.17.
//  Copyright © 2017 EmerShool. All rights reserved.
//

#import "TeachersViewController.h"
#import "TeacherCell.h"

NSString *const kTeacherCellReuseId = @"teacherCellReuseId";

@interface TeachersViewController () 


@end

@implementation TeachersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCellWithClass:[TeacherCell class] reusId:kTeacherCellReuseId];
    
    CellMetaData *cellData = [CellMetaData new];
    cellData.titleCell = @"test";
    cellData.reusIdCell = kTeacherCellReuseId;
    [self.sections addObject:@[cellData]];
}

- (void)processPreparedCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath  {
    NSArray *row = self.sections[indexPath.section];
    CellMetaData *cellData = row[indexPath.row];
    cell.textLabel.text = cellData.titleCell;
}
@end
