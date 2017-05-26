//
//  BaseTableViewController.m
//  EmerShool
//
//  Created by Gbir on 27.05.17.
//  Copyright © 2017 EmerShool. All rights reserved.
//

#import "BaseTableViewController.h"
#import "CellInfo.h"

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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    return cell;
}

@end
