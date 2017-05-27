//
//  SignUpOp.m
//  EmerShool
//
//  Created by Konstantin Krupovich on 26/05/2017.
//  Copyright © 2017 EmerShool. All rights reserved.
//

#import "SignUpOp.h"
#import "AppDelegate.h"
#import "AuthorisationHandler.h"
#import "SignUpRequestOp.h"

@interface SignUpOp ()

@property (nonatomic, copy) NSString *login;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *fio;
@property (nonatomic, copy) NSString *details;

@end

@implementation SignUpOp

- (NSString *)name {
    return @"Авторизация пользователя";
}

- (instancetype)initWithCompletion:(OpCompletionHandler)completion
                             login:(NSString *)login
                          password:(NSString *)password
                               fio:(NSString *)fio
                           details:(NSString *)details {
    if (self = [super initWithCompletion:completion]) {
        self.login = login;
        self.password = password;
        self.fio = fio;
        self.details = details;
        
    }
    return self;
}

- (void)main {
    if (self.isCancelled)
        return [self finish];
    
    __weak SignUpOp *this = self;
    SignUpRequestOp *requestOp = [[SignUpRequestOp alloc] initWithCompletion:^(NSError * _Nullable error, NSString * _Nullable token) {
        this.error = error;
        [APP_DELEGATE.authorisationHandler setAuthToken:token];
        [this finish];
    } login:self.login password:self.password fio:self.fio details:self.details];
    [self.initialQueue addOperation:requestOp];
    
}

@end
