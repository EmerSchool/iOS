//
//  MyProfileViewController.m
//  EmerShool
//
//  Created by Konstantin Krupovich on 26/05/2017.
//  Copyright © 2017 EmerShool. All rights reserved.
//

#import "MyProfileViewController.h"
#import "AppDelegate.h"
#import "AuthorisationHandler.h"

@interface MyProfileViewController ()

@end

@implementation MyProfileViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if (!self.authHandler.isAuthorized) {
        [self performSegueWithIdentifier:@"PresentLoginScreen" sender:self];
    }
}

- (IBAction)logoffButtonPressed:(id)sender {
    [self.authHandler setAuthToken:nil];
    [self performSegueWithIdentifier:@"PresentLoginScreen" sender:self];
}

@end
