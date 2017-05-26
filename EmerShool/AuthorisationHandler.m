//
//  AuthorisationHandler.m
//  EmerShool
//
//  Created by Konstantin Krupovich on 26/05/2017.
//  Copyright © 2017 EmerShool. All rights reserved.
//

#import "AuthorisationHandler.h"

NSString * const kTokenKey = @"TokenKey";

@implementation AuthorisationHandler

- (BOOL)isAuthorized {
    return self.token.length > 0;
}

- (NSString *)token {
    return [[NSUserDefaults standardUserDefaults] stringForKey:kTokenKey];
}

- (void)setAuthToken:(NSString *)authToken {
    if (authToken.length) {
        [[NSUserDefaults standardUserDefaults] setObject:authToken forKey:kTokenKey];
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kTokenKey];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
