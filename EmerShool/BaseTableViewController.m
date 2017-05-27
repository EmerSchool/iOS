//
//  BaseTableViewController.m
//  EmerShool
//
//  Created by Gbir on 27.05.17.
//  Copyright © 2017 EmerShool. All rights reserved.
//

#import "BaseTableViewController.h"
#import "CellMetaData.h"

#import "BaseAsyncOperation.h"

@interface BaseTableViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 60.0f;
    
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    
    [refreshControl addTarget:self action:@selector(onRefreshControlPull:) forControlEvents:UIControlEventValueChanged];
    
    self.tableView.refreshControl = refreshControl;
    
    [self reloadData];
}

- (void)onRefreshControlPull:(UIRefreshControl *)refreshControl {
    __weak BaseTableViewController *this = self;
    [self reloadDataWithCompletion:^(NSError *error, id completionInfo) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (refreshControl)
                [refreshControl endRefreshing];
            
            if (this)
                [this reloadData];
        });
    }];
}

- (void)reloadDataWithCompletion:(ReloadCompletionHandler)completion {
    completion(nil, nil);
}

- (void)reloadData {
    [self loadData];
    [self.tableView reloadData];

}

- (void)loadData {
    self.sections = [NSMutableArray new];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)prepareCellForReusableId:(NSString *)reusableId {
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusableId];
}

- (void)processPreparedCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    ;
}

@end
