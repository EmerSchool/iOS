//
//  LoginViewController.h
//  EmerShool
//
//  Created by Konstantin Krupovich on 26/05/2017.
//  Copyright © 2017 EmerShool. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *loginField;
@property (weak, nonatomic) IBOutlet UITextField *passwordFiled;

- (IBAction)loginButtonPressed:(id)sender;

@end
