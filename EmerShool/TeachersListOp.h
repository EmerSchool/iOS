//
//  TeachersListOp.h
//  EmerShool
//
//  Created by Konstantin Krupovich on 27/05/2017.
//  Copyright © 2017 EmerShool. All rights reserved.
//

#import "BaseServerRequestOperation.h"

typedef void (^TeachersListCompletionHandler)(NSError * _Nullable error, NSArray <NSDictionary *> * _Nullable teachersList);

extern NSString * const kResultListKey;

@interface TeachersListOp : BaseServerRequestOperation

- (instancetype)initWithCompletion:(TeachersListCompletionHandler _Nonnull )completion
                             token:(NSString *_Nonnull)token;

@end
