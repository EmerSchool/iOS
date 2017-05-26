//
//  BaseViewController.h
//  EmerShool
//
//  Created by Konstantin Krupovich on 26/05/2017.
//  Copyright © 2017 EmerShool. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AuthorisationHandler;

@interface BaseViewController : UIViewController

@property (nonatomic, readonly) NSOperationQueue *defaultQueue;
@property (readonly) AuthorisationHandler *authHandler;

@end
