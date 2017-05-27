//
//  LoginRequestOp.h
//  EmerShool
//
//  Created by Konstantin Krupovich on 27/05/2017.
//  Copyright © 2017 EmerShool. All rights reserved.
//

#import "BaseServerRequestOperation.h"

typedef void (^LoginRequestCompletionHandler)(NSError * _Nullable error, NSString * _Nullable token);

@interface LoginRequestOp : BaseServerRequestOperation

- (instancetype _Nonnull )initWithCompletion:(nonnull LoginRequestCompletionHandler)completion login:(NSString *_Nonnull)login password:(NSString *_Nonnull)password;

@end
