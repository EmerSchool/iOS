//
//  BaseServerRequestOperation+Utils.h
//  EmerShool
//
//  Created by Konstantin Krupovich on 27/05/2017.
//  Copyright © 2017 EmerShool. All rights reserved.
//

#import "BaseServerRequestOperation.h"

@interface BaseServerRequestOperation (Utils)

+ (void)spoolData:(NSData *)data fileNameMask:(NSString *)fileNameMask method:(NSString *)method;

@end
