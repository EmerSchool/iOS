//
//  SignUpViewController.h
//  EmerShool
//
//  Created by Konstantin Krupovich on 26/05/2017.
//  Copyright © 2017 EmerShool. All rights reserved.
//

#import "BaseViewController.h"

@interface SignUpViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *loginField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *fioField;
@property (weak, nonatomic) IBOutlet UITextField *infoField;

- (IBAction)signUpButtonPressed:(id)sender;

@end
