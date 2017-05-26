//
//  AppDelegate.h
//  EmerShool
//
//  Created by Konstantin Krupovich on 26/05/2017.
//  Copyright © 2017 EmerShool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#define APP_DELEGATE ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@class AuthorisationHandler;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property (nonatomic, readonly) AuthorisationHandler *authorisationHandler;

- (void)saveContext;


@end

