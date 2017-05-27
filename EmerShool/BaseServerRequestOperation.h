//
//  BaseServerRequestOperation.h
//  EmerShool
//
//  Created by Konstantin Krupovich on 26/05/2017.
//  Copyright © 2017 EmerShool. All rights reserved.
//

#import "BaseAsyncOperation.h"

typedef void (^ServerRequestCompletionHandler)(NSError *error, NSDictionary *result);

@interface BaseServerRequestOperation : BaseAsyncOperation

- (instancetype)initWithCompletion:(ServerRequestCompletionHandler)completion serverMethodName:(NSString *)serverMethodName params:(NSDictionary *)params;

@end

#import "BaseServerRequestOperation+Utils.h"
