//
//  BaseTableViewController.h
//  EmerShool
//
//  Created by Gbir on 27.05.17.
//  Copyright © 2017 EmerShool. All rights reserved.
//

#import "BaseViewController.h"
#import "CellMetaData.h"

typedef void (^ReloadCompletionHandler)(NSError *error, id completionInfo);

@interface BaseTableViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray <NSArray *> *sections;

- (void)registerCellWithClass:(Class) classCell reusId:(NSString *)reusId;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)processPreparedCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath ;

//! Загрузка и обновление таблицы
- (void)reloadData;
//! Загрузка данных
- (void)loadData;

//! Для асинхронной загрузки данных
- (void)reloadDataWithCompletion:(ReloadCompletionHandler)completion;

@end
