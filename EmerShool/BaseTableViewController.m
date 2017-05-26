//
//  BaseTableViewController.m
//  EmerShool
//
//  Created by Gbir on 27.05.17.
//  Copyright © 2017 EmerShool. All rights reserved.
//

#import "BaseTableViewController.h"
#import "CellMetaData.h"

@interface BaseTableViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sections = [NSMutableArray new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)registerCellWithClass:(Class) classCell reusId:(NSString *)reusId {
    UINib *nibCell =
    [UINib nibWithNibName:NSStringFromClass([classCell class])
                   bundle:nil];
    [self.tableView registerNib:nibCell
         forCellReuseIdentifier:reusId];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *rows = self.sections[section];
    return rows.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}
 
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *rows = self.sections[indexPath.section];
    CellMetaData *cellData = rows[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellData.reusIdCell];
    
    if (!cell)
        cell = [self prepareCellForReusableId:cellData.reusIdCell];
    
    [self processPreparedCell:cell forIndexPath:indexPath];
    
    return cell;
}

- (UITableViewCell *)prepareCellForReusableId:(NSString *)reusableId {
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusableId];
}

- (void)processPreparedCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    ;
}

@end
