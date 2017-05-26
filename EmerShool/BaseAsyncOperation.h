//
//  BaseAsyncOperation.h
//  EmerShool
//
//  Created by Konstantin Krupovich on 26/05/2017.
//  Copyright © 2017 EmerShool. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ErrorCodeEnum) {
    ErrorCodeNA,
    ErrorCodeOpCanceled
};

typedef void (^OpCompletionHandler)(NSError *error, id completionInfo);

extern NSString * const kInnerErrorKey;

@interface BaseAsyncOperation : NSOperation

@property (nonatomic, copy, readonly) NSError *error;
@property (nonatomic, readonly) id completionInfo;

@property (nonatomic, readonly) NSOperationQueue *initialQueue;

- (id)initWithCompletion:(OpCompletionHandler)completion;

- (void)finish;

@end
