//
//  TeachersListRequestOp.m
//  EmerShool
//
//  Created by Konstantin Krupovich on 27/05/2017.
//  Copyright © 2017 EmerShool. All rights reserved.
//

#import "TeachersListRequestOp.h"

@implementation TeachersListRequestOp

- (instancetype _Nonnull )initWithCompletion:(nonnull TeachersListRequestCompletionHandler)completion
                                       token:(NSString *_Nonnull)token
{
    if (self = [super initWithCompletion:^(NSError *error, NSDictionary *result) { completion(error, result); }
                        serverMethodName:@"teacher/list"
                                  params:@{
                                           @"token":token
                                           }]) {
        ;
    }
    return self;
}

@end
