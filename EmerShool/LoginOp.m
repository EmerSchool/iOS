//
//  LoginOp.m
//  EmerShool
//
//  Created by Konstantin Krupovich on 26/05/2017.
//  Copyright © 2017 EmerShool. All rights reserved.
//

#import "LoginOp.h"
#import "AppDelegate.h"
#import "AuthorisationHandler.h"

@implementation LoginOp

- (NSString *)name {
    return @"Авторизация пользователя";
}

- (void)main {
    if (self.isCancelled)
        return [self finish];
    
    [APP_DELEGATE.authorisationHandler setAuthToken:@"xxx"];
    [self finish];
}

@end
