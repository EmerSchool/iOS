//
//  BaseAsyncOperation.m
//  EmerShool
//
//  Created by Konstantin Krupovich on 26/05/2017.
//  Copyright © 2017 EmerShool. All rights reserved.
//

#import "BaseAsyncOperation.h"
#import "AppDelegate.h"

NSString * const kInnerErrorKey = @"InnerErrorKey";

@interface BaseAsyncOperation () {
    BOOL _executing;
    BOOL _finished;
}

@property (copy) OpCompletionHandler completion;

@end

@implementation BaseAsyncOperation

- (NSString *)name {
    return @"базовая асинхронная операция";
}

- (id)initWithCompletion:(OpCompletionHandler)completion {
    if (self = [super init]) {
        self.completion = completion;
    }
    return self;
}

- (BOOL)isConcurrent {
    return YES;
}

- (BOOL)isExecuting {
    return _executing;
}

- (BOOL)isFinished {
    return _finished;
}

- (void)start {
    
    _error = nil;//на всякий случай
    
    [self willChangeValueForKey:@"isExecuting"];
    _executing = YES;
    [self didChangeValueForKey:@"isExecuting"];
    
    _initialQueue = [NSOperationQueue currentQueue];
    
    
    [self main];
}

- (void)finish {
    if (self.completion)
        self.completion(self.isCancelled ? [NSError errorWithDomain:@"async_operation_error"
                                                               code:ErrorCodeOpCanceled
                                                           userInfo:@{kInnerErrorKey:_error,
                                                                      NSLocalizedDescriptionKey:[NSString stringWithFormat:@"Действие отменено: %@", self.name]
                                                                      }] : _error, _completionInfo);
    
    [self willChangeValueForKey:@"isExecuting"];
    _executing = NO;
    [self didChangeValueForKey:@"isExecuting"];
    [self willChangeValueForKey:@"isFinished"];
    _finished = YES;
    [self didChangeValueForKey:@"isFinished"];
}

@end
