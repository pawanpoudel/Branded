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
        CCHMenuTableDataSource *dataSource = [[CCHMenuTableDataSource alloc] init];
        [dataSource setMenuItems:self.menuItems];
        
        CCHMenuViewController *menuViewController = [[CCHMenuViewController alloc] init];
        menuViewController.dataSource = dataSource;
        
        self.slidingViewController.underLeftViewController = menuViewController;
    }
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}

#pragma mark - Menu items management

- (NSArray *)menuItems {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"menuItems"
                                                         ofType:@"plist"];
    
    NSArray *fileContent = [NSArray arrayWithContentsOfFile:filePath];
    NSMutableArray *menuItems = [self createMenuItemsFromArray:fileContent];
    
    [self removeDisabledFeaturesFromMenuItems:menuItems];
    return menuItems;
}

- (NSMutableArray *)createMenuItemsFromArray:(NSArray *)fileContent {
    NSMutableArray *menuItems = [NSMutableArray arrayWithCapacity:[fileContent count]];
    
    [fileContent enumerateObjectsUsingBlock:^(NSDictionary *item, NSUInteger index, BOOL *stop) {
        CCHMenuItem *menuItem = [[CCHMenuItem alloc] init];
        menuItem.title = item[@"title"];
        menuItem.subTitle = item[@"subTitle"];
        menuItem.icon = [UIImage imageNamed:item[@"iconName"]];
        menuItem.backgroundImage = [UIImage imageNamed:item[@"backgroundImageName"]];
        menuItem.rowHeight = [item[@"rowHeight"] floatValue];
        menuItem.tapEventHandlerClassName = item[@"tapEventHandler"];
        menuItem.featureName = item[@"featureName"];
        
        [menuItems addObject:menuItem];
    }];
    
    return [menuItems copy];
}

- (void)removeDisabledFeaturesFromMenuItems:(NSMutableArray *)allItems {
    [allItems enumerateObjectsUsingBlock:^(CCHMenuItem *menuItem, NSUInteger index, BOOL *stop) {
        NSArray *features = [[CCHFeatureManager sharedInstance] features];
        if ([features containsObject:menuItem.featureName] == NO) {
            [allItems removeObject:menuItem];
        }
    }];
}

@end
