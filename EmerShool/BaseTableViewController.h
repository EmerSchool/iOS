//
//  BaseTableViewController.h
//  EmerShool
//
//  Created by Gbir on 27.05.17.
//  Copyright © 2017 EmerShool. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseTableViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray <NSArray *> *sections;

- (void)registerCellWithClass:(Class) classCell reusId:(NSString *)reusId;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
