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
#import "LoginRequestOp.h"

@interface LoginOp ()

@property (nonatomic, copy) NSString *login;
@property (nonatomic, copy) NSString *password;

@end

@implementation LoginOp

- (NSString *)name {
    return @"Авторизация пользователя";
}

- (instancetype)initWithCompletion:(OpCompletionHandler)completion login:(NSString *)login password:(NSString *)password {
    if (self = [super initWithCompletion:completion]) {
        self.login = login;
        self.password = password;
    }
    return self;
}

- (void)main {
    if (self.isCancelled)
        return [self finish];

    __weak LoginOp *this = self;
    LoginRequestOp *requestOp = [[LoginRequestOp alloc] initWithCompletion:^(NSError * _Nullable error, NSString * _Nullable token) {
        this.error = error;
        [APP_DELEGATE.authorisationHandler setAuthToken:token];
        [this finish];
    } login:self.login password:self.password];
    [self.initialQueue addOperation:requestOp];
    
}

@end
