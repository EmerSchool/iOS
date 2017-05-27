//
//  TeachersViewController.h
//  EmerShool
//
//  Created by Gbir on 27.05.17.
//  Copyright © 2017 EmerShool. All rights reserved.
//

#import "BaseTableViewController.h"

@interface TeachersViewController : BaseTableViewController

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addTeacherToolbarTopConstraint;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addTeacherMenuToggler;

- (IBAction)addTeacherTogglerButtonPressed:(id)sender;

@end
