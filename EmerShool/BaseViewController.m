//
//  BaseViewController.m
//  EmerShool
//
//  Created by Konstantin Krupovich on 26/05/2017.
//  Copyright © 2017 EmerShool. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"
#import "AuthorisationHandler.h"

@interface BaseViewController ()


@end

@implementation BaseViewController

- (AuthorisationHandler *)authHandler {
    return APP_DELEGATE.authorisationHandler;
}

- (instancetype)init {
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    _defaultQueue = [NSOperationQueue new];
}

@end
