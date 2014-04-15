//
//  CCHAppDelegate.m
//  Branded
//
//  Created by PAWAN POUDEL on 4/14/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

#import "CCHAppDelegate.h"
#import "CCHInitialSlidingViewController.h"
#import "CCHSlidingNavigationController.h"
#import "CCHHomeViewController.h"
#import "CCHLogInViewController.h"

@interface CCHAppDelegate()

@property (nonatomic) CCHSlidingNavigationController *rootNavController;
@property (readwrite, nonatomic) UINavigationController *loginNavController;

@end

@implementation CCHAppDelegate

#pragma mark - Accessors

- (CCHSlidingNavigationController *)rootNavController {
    if (_rootNavController == nil) {
        CCHHomeViewController *homeViewController = [[CCHHomeViewController alloc] init];
        _rootNavController = [[CCHSlidingNavigationController alloc] initWithRootViewController:homeViewController];
    }
    
    return _rootNavController;
}

- (UINavigationController *)loginNavController {
    if (_loginNavController == nil) {
        CCHLogInViewController *loginViewController = [[CCHLogInViewController alloc] init];
        _loginNavController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
        _loginNavController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    }
    
    return _loginNavController;
}

#pragma mark - App lifecycle

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self addRootViewController];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)addRootViewController {
    CCHInitialSlidingViewController *slidingViewController = [[CCHInitialSlidingViewController alloc] init];
    slidingViewController.topViewController = self.rootNavController;
    self.window.rootViewController = slidingViewController;
}

#pragma mark - Convenience methods

+ (CCHAppDelegate *)sharedAppDelegate {
    return (CCHAppDelegate *)[[UIApplication sharedApplication] delegate];
}

@end
