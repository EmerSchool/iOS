//
//  SignUpOp.h
//  EmerShool
//
//  Created by Konstantin Krupovich on 26/05/2017.
//  Copyright © 2017 EmerShool. All rights reserved.
//

#import "BaseAsyncOperation.h"

@interface SignUpOp : BaseAsyncOperation

- (instancetype)initWithCompletion:(OpCompletionHandler)completion
                             login:(NSString *)login
                          password:(NSString *)password
                               fio:(NSString *)fio
                           details:(NSString *)details;

@end
