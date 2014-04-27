//
//  CCHSlidingNavigationController.m
//  Branded
//
//  Created by PAWAN POUDEL on 4/14/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

#import "CCHSlidingNavigationController.h"
#import "ECSlidingViewController.h"
#import "CCHMenuViewController.h"
#import "CCHMenuTableDataSource.h"
#import "CCHMenuItem.h"
#import "CCHMenuItemsPlistReader.h"
#import "CCHMenuItemBuilder.h"
#import "CCHFeatureManager.h"

@implementation CCHSlidingNavigationController

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self applyShadowToView];
    [self setupSlidingViewController];
}

- (void)applyShadowToView {
    // shadowPath, shadowOffset, and rotation is handled by ECSlidingViewController.
    // Just set the opacity, radius, and color here.
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
}

- (void)setupSlidingViewController {
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[CCHMenuViewController class]]) {
        CCHMenuItemsPlistReader *menuItemsPlistReader = [[CCHMenuItemsPlistReader alloc] init];
        menuItemsPlistReader.plistToReadFrom = @"menuItems";
        
        CCHMenuItemBuilder *menuItemBuilder = [[CCHMenuItemBuilder alloc] init];
        [menuItemBuilder setMenuReader:menuItemsPlistReader];
        
        NSArray *enabledFeatures = [[CCHFeatureManager sharedInstance] features];
        NSArray *menuItems = [menuItemBuilder menuItemsForEnabledFeatures:enabledFeatures];
        
        CCHMenuTableDataSource *dataSource = [[CCHMenuTableDataSource alloc] init];
        [dataSource setMenuItems:menuItems];
        
        CCHMenuViewController *menuViewController = [[CCHMenuViewController alloc] init];
        menuViewController.dataSource = dataSource;
        
        self.slidingViewController.underLeftViewController = menuViewController;
    }
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}

@end
