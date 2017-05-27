//
//  TeachersListRequestOp.h
//  EmerShool
//
//  Created by Konstantin Krupovich on 27/05/2017.
//  Copyright © 2017 EmerShool. All rights reserved.
//

#import "BaseServerRequestOperation.h"

typedef void (^TeachersListRequestCompletionHandler)(NSError * _Nullable error, NSDictionary * _Nullable result);

@interface TeachersListRequestOp : BaseServerRequestOperation

- (instancetype _Nonnull )initWithCompletion:(nonnull TeachersListRequestCompletionHandler)completion
                                       token:(NSString *_Nonnull)token;

@end
