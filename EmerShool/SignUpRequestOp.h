//
//  SignUpRequestOp.h
//  EmerShool
//
//  Created by Konstantin Krupovich on 27/05/2017.
//  Copyright © 2017 EmerShool. All rights reserved.
//

#import "BaseServerRequestOperation.h"

typedef void (^SignUpRequestCompletionHandler)(NSError * _Nullable error, NSString * _Nullable token);

@interface SignUpRequestOp : BaseServerRequestOperation

- (instancetype _Nonnull )initWithCompletion:(nonnull SignUpRequestCompletionHandler)completion
                                       login:(NSString *_Nonnull)login
                                    password:(NSString *_Nonnull)password
                                         fio:(NSString *_Nonnull)fio
                                     details:(NSString *_Nonnull)details;


@end
