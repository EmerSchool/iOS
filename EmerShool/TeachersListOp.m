//
//  TeachersListOp.m
//  EmerShool
//
//  Created by Konstantin Krupovich on 27/05/2017.
//  Copyright © 2017 EmerShool. All rights reserved.
//

#import "TeachersListOp.h"
#import "TeachersListRequestOp.h"

NSString * const kResultListKey = @"list";

@interface TeachersListOp ()

@property (copy, nonatomic) NSString *token;

@property (copy) TeachersListCompletionHandler listCompletion;
@property (strong, nonatomic) NSArray <NSDictionary *> *resultList;

@end

@implementation TeachersListOp

- (instancetype)initWithCompletion:(TeachersListCompletionHandler _Nonnull)completion
                             token:(NSString * _Nonnull)token {
    if (self = [super initWithCompletion:nil]) {
        self.listCompletion = completion;
        self.token = token;
    }
    return self;
}

//! мокап
- (void)main {
    if (self.isCancelled)
        return [self finish];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"teacher_list" ofType:@"plist"];
    NSArray *result = [NSArray arrayWithContentsOfFile:path];
    self.resultList = result;
    
    [self finish];
}

- (void)_main {
    if (self.isCancelled)
        return [self finish];
    
    __weak TeachersListOp *this = self;

    TeachersListRequestOp *requestOp = [[TeachersListRequestOp alloc] initWithCompletion:^(NSError * _Nullable error, NSDictionary * _Nullable result) {
        this.error = error;
        this.resultList = result[kResultListKey];
        [this finish];
    } token:self.token];

    [self.initialQueue addOperation:requestOp];
}

- (void)finish {
    self.listCompletion(self.error, self.resultList);
    [super finish];
}

@end
