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

@interface BaseServerRequestOperation ()

@property (nonatomic, readonly) NSURL *baseURL;
@property (nonatomic, copy) NSString *serverMethodName;

@property (nonatomic, copy) NSDictionary *params;
@property (nonatomic, strong) NSDictionary *result;

@property (copy) ServerRequestCompletionHandler serverCompletion;

@end

@implementation BaseServerRequestOperation

- (NSURL *)baseURL {
    NSURL *retval = [[NSUserDefaults standardUserDefaults] URLForKey:kBaseURLKey];
    if (!retval) {
        retval = [NSURL URLWithString:@"http://104.131.178.134:80"];
        [[NSUserDefaults standardUserDefaults] setURL:retval forKey:kBaseURLKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    return retval;
}

- (instancetype)initWithCompletion:(ServerRequestCompletionHandler)completion serverMethodName:(NSString *)serverMethodName params:(NSDictionary *)params {
    if (self = [super initWithCompletion:nil]) {
        self.serverCompletion = completion;
        self.serverMethodName = serverMethodName;
        self.params = params;
    }
    return self;
}

- (void)finish {
    if (self.serverCompletion)
        self.serverCompletion(self.resultError, self.result);
    
    [super finish];
}

- (NSURLRequest *)prepareRequest {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[self.baseURL URLByAppendingPathComponent:self.serverMethodName]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:kDefaultRequestTimeout];
    
    [request setHTTPMethod:httpMethod];
    [request setValue:httpHeaderContentType forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSError *error = nil;
    NSString *serializedParams = [self serializeParams:self.params];
    NSData *postdata = [serializedParams dataUsingEncoding:NSUTF8StringEncoding];//[NSJSONSerialization dataWithJSONObject:self.params options:NSJSONWritingPrettyPrinted error:&error];//[NSJSONSerialization dataWithJSONObject:self.params options:0 error:&error];
    if (!error)
        [request setHTTPBody:postdata];
    else {
        self.error = error;
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
        this.error = [NSError errorWithDomain:@"no request data" code:ErrorCodeNoServerRequest userInfo:nil];
        [self finish];
    }
    
    NSURLSessionDataTask *sessionTask = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                        completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        
        if (this.isCancelled)
            return [this finish];
        
        if (error) {
            this.error = error;
            return [this finish];
        }
        
        if (!response) {
            this.error = [NSError errorWithDomain:@"no response data" code:ErrorCodeNoServerResponce userInfo:nil];
            return [this finish];
        }
        [BaseServerRequestOperation spoolData:data fileNameMask:@"%@/%f_server_data_for_%@" method:this.serverMethodName];
        
        NSError *parseError = nil;
        NSMutableDictionary *result = [[NSMutableDictionary alloc] initWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&parseError]];
        
        if (parseError) {
            this.error = parseError;
            return [this finish];
        }
        
        this.result = result;
        
        [this finish];
        
    }];
    [sessionTask resume];
}
- (NSString *)serializeParams:(NSDictionary *)params {
    NSMutableArray *pairs = NSMutableArray.array;
    for (NSString *key in params.keyEnumerator) {
        id value = params[key];
        if ([value isKindOfClass:[NSDictionary class]])
            for (NSString *subKey in value)
                [pairs addObject:[NSString stringWithFormat:@"%@[%@]=%@", key, subKey, [self escapeValueForURLParameter:[value objectForKey:subKey]]]];
        
        else if ([value isKindOfClass:[NSArray class]])
            for (NSString *subValue in value)
                [pairs addObject:[NSString stringWithFormat:@"%@[]=%@", key, [self escapeValueForURLParameter:subValue]]];
        
        else
            [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, [self escapeValueForURLParameter:value]]];
        
    }
    return [pairs componentsJoinedByString:@"&"];
}

- (NSString *)escapeValueForURLParameter:(NSString *)valueToEscape {
    return [valueToEscape stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"!*'();:@&=+$,/?%#[]"]];
//    return (__bridge_transfer NSString *) CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef) valueToEscape,
//                                                                                  NULL, (CFStringRef) @"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
}

@end
