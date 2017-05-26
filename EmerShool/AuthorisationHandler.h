//
//  AuthorisationHandler.h
//  EmerShool
//
//  Created by Konstantin Krupovich on 26/05/2017.
//  Copyright © 2017 EmerShool. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuthorisationHandler : NSObject

@property (nonatomic, readonly) BOOL isAuthorized;

@property (nonatomic, readonly) NSString *token;

- (void)setAuthToken:(NSString *)authToken;

@end
