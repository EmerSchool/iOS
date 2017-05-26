//
//  TeachersViewController.m
//  EmerShool
//
//  Created by Gbir on 27.05.17.
//  Copyright © 2017 EmerShool. All rights reserved.
//

#import "TeachersViewController.h"
#import "TeacherCell.h"

@interface TeachersViewController () 


@end

@implementation TeachersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCellWithClass:[TeacherCell class] reusId:@"cell"];
    [self.sections addObject:@[@1]];
}

@end
