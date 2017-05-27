//
//  SignUpRequestOp.m
//  EmerShool
//
//  Created by Konstantin Krupovich on 27/05/2017.
//  Copyright © 2017 EmerShool. All rights reserved.
//

#import "SignUpRequestOp.h"

@implementation SignUpRequestOp

- (instancetype _Nonnull )initWithCompletion:(nonnull SignUpRequestCompletionHandler)completion
                                       login:(NSString *_Nonnull)login
                                    password:(NSString *_Nonnull)password
                                         fio:(NSString *_Nonnull)fio
                                     details:(NSString *_Nonnull)details
{
    if (self = [super initWithCompletion:^(NSError *error, NSDictionary *result) { completion(error, result[@"token"]); }
                        serverMethodName:@"register"
                                  params:@{
                                           @"login":login,
                                           @"password":password,
                                           @"name":fio,
                                           @"details":details
                                           }]) {
        ;
    }
    return self;
}

@end
