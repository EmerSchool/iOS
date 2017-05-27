//
//  LoginViewController.m
//  EmerShool
//
//  Created by Konstantin Krupovich on 26/05/2017.
//  Copyright © 2017 EmerShool. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginOp.h"

#import "AuthorisationHandler.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (IBAction)loginButtonPressed:(id)sender {
    
    //TODO: validate model etc...
    __weak LoginViewController *this = self;
    
    LoginOp *loginOp = [[LoginOp alloc] initWithCompletion:^(NSError *error, id completionInfo) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error && [this.authHandler isAuthorized]) {
                [this dismiss];
            } else {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Ошибка авторизации"
                                                                               message:error.localizedDescription
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    ;
                }]];
                [self presentViewController:alert animated:YES completion:NULL];
            }
        });
    } login:self.loginField.text password:self.passwordFiled.text];
    [self.defaultQueue addOperation:loginOp];
}

- (void)dismiss {
    [self.presentingViewController dismissViewControllerAnimated:self.presentingViewController.presentedViewController
                                                      completion:^{
                                                          ;
                                                      }];
}

@end
