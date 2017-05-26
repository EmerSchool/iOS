//
//  BaseServerRequestOperation.m
//  EmerShool
//
//  Created by Konstantin Krupovich on 26/05/2017.
//  Copyright © 2017 EmerShool. All rights reserved.
//

#import "BaseServerRequestOperation.h"

NSString * const kBaseURLKey = @"BaseURLKey";
NSTimeInterval const kDefaultRequestTimeout = 10;//10 секунд
NSString * const httpHeaderContentType = @"application/x-www-form-urlencoded";
NSString * const httpMethod = @"POST";

@interface BaseServerRequestOperation () {
    NSError * _error;
}

@property (nonatomic, readonly) NSURL *baseURL;
@property (nonatomic, copy) NSString *serverMethodName;

@property (nonatomic, copy) NSDictionary *params;
@property (nonatomic, strong) NSDictionary *result;

@property (nonatomic, copy) NSError *serverError;

@end

@implementation BaseServerRequestOperation

- (NSError *)error {
    return _serverError;
}

- (NSURL *)baseURL {
    NSURL *retval = [[NSUserDefaults standardUserDefaults] URLForKey:kBaseURLKey];
    if (!retval) {
        retval = [NSURL URLWithString:@"http://104.131.178.134:80"];
        [[NSUserDefaults standardUserDefaults] setURL:retval forKey:kBaseURLKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    return retval;
}

- (instancetype)initWithCompletion:(OpCompletionHandler)completion serverMethodName:(NSString *)serverMethodName params:(NSDictionary *)params {
    if (self = [super initWithCompletion:completion]) {
        self.serverMethodName = serverMethodName;
        self.params = params;
    }
    return self;
}

- (NSURLRequest *)prepareRequest {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[self.baseURL URLByAppendingPathComponent:self.serverMethodName]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:kDefaultRequestTimeout];
    
    [request setHTTPMethod:httpMethod];
    [request setValue:httpHeaderContentType forHTTPHeaderField:@"Content-Type"];
    
    NSError *error = nil;
    NSData *postdata = [NSJSONSerialization dataWithJSONObject:self.params options:0 error:&error];
    if (!error)
        [request setHTTPBody:postdata];
    else {
        self.serverError = error;
        [self finish];
    }
    return request;
}

- (void)main {
    if (self.isCancelled)
        return [self finish];

    __weak BaseServerRequestOperation *this = self;
    
    NSURLRequest *request = [self prepareRequest];
    
    if (!request) {
        this.serverError = [NSError errorWithDomain:@"no request data" code:ErrorCodeNoServerRequest userInfo:nil];
        [self finish];
    }
    
    NSURLSessionDataTask *sessionTask = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                        completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        
        if (this.isCancelled)
            return [this finish];
        
        if (error) {
            this.serverError = error;
            return [this finish];
        }
        
        if (!response) {
            this.serverError = [NSError errorWithDomain:@"no response data" code:ErrorCodeNoServerResponce userInfo:nil];
            return [this finish];
        }
        
        NSError *parseError = nil;
        NSMutableDictionary *result = [[NSMutableDictionary alloc] initWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&parseError]];
        
        if (parseError) {
            this.serverError = parseError;
            return [this finish];
        }
        
        this.result = result;
        
        [this finish];
        
    }];
    [sessionTask resume];
}

@end
