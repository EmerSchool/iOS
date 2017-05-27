//
//  LoginRequestOp.m
//  EmerShool
//
//  Created by Konstantin Krupovich on 27/05/2017.
//  Copyright © 2017 EmerShool. All rights reserved.
//

#import "LoginRequestOp.h"

@implementation LoginRequestOp

- (instancetype _Nonnull )initWithCompletion:(nonnull LoginRequestCompletionHandler)completion login:(NSString *_Nonnull)login password:(NSString *_Nonnull)password {
    if (self = [super initWithCompletion:^(NSError *error, NSDictionary *result) { completion(error, result[@"token"]); }
                        serverMethodName:@"login"
                                  params:@{
                                           @"login":login,
                                           @"password":password
                                           }]) {
        ;
    }
    return self;
}

@end
