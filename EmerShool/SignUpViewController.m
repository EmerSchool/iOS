//
//  SignUpViewController.m
//  EmerShool
//
//  Created by Konstantin Krupovich on 26/05/2017.
//  Copyright © 2017 EmerShool. All rights reserved.
//

#import "SignUpViewController.h"
#import "SignUpOp.h"

#import "AuthorisationHandler.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
}

- (IBAction)signUpButtonPressed:(id)sender {
    //TODO: validate model etc...
    __weak SignUpViewController *this = self;
    
    SignUpOp *signUpOp = [[SignUpOp alloc] initWithCompletion:^(NSError *error, id completionInfo) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error && [this.authHandler isAuthorized]) {
                [this dismiss];
            } else {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Ошибка регистрации"
                                                                               message:error.localizedDescription
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    ;
                }]];
                [self presentViewController:alert animated:YES completion:NULL];
            }
        });
    } login:self.loginField.text password:self.passwordField.text fio:self.fioField.text details:self.infoField.text];
    [self.defaultQueue addOperation:signUpOp];
}

- (void)dismiss {
    [self.presentingViewController dismissViewControllerAnimated:self.presentingViewController.presentedViewController
                                                      completion:^{
                                                          ;
                                                      }];
}

@end
