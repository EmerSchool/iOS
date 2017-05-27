//
//  LoginOp.h
//  EmerShool
//
//  Created by Konstantin Krupovich on 26/05/2017.
//  Copyright © 2017 EmerShool. All rights reserved.
//

#import "BaseAsyncOperation.h"

@interface LoginOp : BaseAsyncOperation

- (instancetype)initWithCompletion:(OpCompletionHandler)completion
                             login:(NSString *)login
                          password:(NSString *)password;

@end
