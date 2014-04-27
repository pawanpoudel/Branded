//
//  CCHMenuItemBuilder.m
//  Branded
//
//  Created by PAWAN POUDEL on 4/26/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

#import "CCHMenuItemBuilder.h"
#import "CCHMenuItem.h"

@interface CCHMenuItemBuilder ()

@property (nonatomic) id<CCHMenuItemsReader> menuReader;
@property (nonatomic) NSArray *enabledFeatures;

@end

@implementation CCHMenuItemBuilder

#pragma mark - Menu items management

- (NSArray *)menuItemsForEnabledFeatures:(NSArray *)features {
    self.enabledFeatures = features;
    NSArray *rawMenuItems = [self.menuReader readMenuItems];
    NSArray *menuItems = [self createMenuItemsFromRawItems:rawMenuItems];
    return [self removeDisabledFeaturesFromMenuItems:menuItems];
}

- (NSArray *)createMenuItemsFromRawItems:(NSArray *)rawMenuItems {
    NSMutableArray *menuItems = [NSMutableArray array];
    
    for (NSDictionary *rawItem in rawMenuItems) {
        CCHMenuItem *menuItem = [[CCHMenuItem alloc] init];
        menuItem.title = rawItem[@"title"];
        menuItem.subTitle = rawItem[@"subTitle"];
        menuItem.icon = [UIImage imageNamed:rawItem[@"iconName"]];
        menuItem.backgroundImage = [UIImage imageNamed:rawItem[@"backgroundImageName"]];
        menuItem.rowHeight = [rawItem[@"rowHeight"] floatValue];
        menuItem.tapEventHandlerClassName = rawItem[@"tapEventHandler"];
        menuItem.featureName = rawItem[@"featureName"];
        
        [menuItems addObject:menuItem];
    }
    
    return [menuItems copy];
}

- (NSArray *)removeDisabledFeaturesFromMenuItems:(NSArray *)menuItems {
    NSMutableArray *enabledMenuItems = [NSMutableArray array];
    
    for (CCHMenuItem *menuItem in menuItems) {
        if ([self devSettingsMenuItem:menuItem]) {
            [enabledMenuItems addObject:menuItem];
        }
        
        if ([self.enabledFeatures containsObject:menuItem.featureName]) {
            [enabledMenuItems addObject:menuItem];
        }
    }
    
    return [enabledMenuItems copy];
}

- (BOOL)devSettingsMenuItem:(CCHMenuItem *)menuItem {
#ifdef DEBUG
    if ([menuItem.featureName isEqualToString:@"devSettings"]) {
        return YES;
    }
#endif
    
    return NO;
}

@end
