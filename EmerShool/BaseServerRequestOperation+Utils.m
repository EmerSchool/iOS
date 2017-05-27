//
//  BaseServerRequestOperation+Utils.m
//  EmerShool
//
//  Created by Konstantin Krupovich on 27/05/2017.
//  Copyright © 2017 EmerShool. All rights reserved.
//

#import "BaseServerRequestOperation+Utils.h"

@implementation BaseServerRequestOperation (Utils)
+ (NSString *)debugOutputPath
{
    NSString *path = @"";
    NSArray *components = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] componentsSeparatedByString:@"/"];
    
    for (NSInteger i = 0; i < components.count; ++i) {
        NSString *component = components[i];
        path = [path stringByAppendingPathComponent:component];
        if ([component isEqualToString:@"Users"]) {
            path = [path stringByAppendingPathComponent:components[i+1]];
            path = [path stringByAppendingPathComponent:@"Downloads"];
            path = [path stringByAppendingPathComponent:@"debugOutput"];
            break;
        }
    }
    return path;
}

+ (void)spoolData:(NSData *)data fileNameMask:(NSString *)fileNameMask method:(NSString *)method {
#ifdef DEBUG
#if TARGET_IPHONE_SIMULATOR
    NSString *path = [self debugOutputPath];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path])
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *filePath = [NSString stringWithFormat:fileNameMask,
                          path,
                          [[NSDate date] timeIntervalSince1970],
                          (method.length > 0 ? method : @"xxx")];
    [(data ? data : [NSData data]) writeToFile:filePath atomically:YES];
#endif
#endif
}
@end
