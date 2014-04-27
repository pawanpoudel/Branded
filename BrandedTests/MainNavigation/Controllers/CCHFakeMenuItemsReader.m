//
//  CCHFakeMenuItemsReader.m
//  Branded
//
//  Created by PAWAN POUDEL on 4/26/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

#import "CCHFakeMenuItemsReader.h"

@implementation CCHFakeMenuItemsReader

- (NSArray *)readMenuItems {
    NSDictionary *menuItem1 = @{ @"title": @"Menu Item 1",
                                 @"subTitle": @"Tap here",
                                 @"iconName": @"testImage",
                                 @"featureName": @"feature1",
                                 @"rowHeight": @"100",
                                 @"tapEventHandler": @"TestEventHandler1"
                                 };
    
    NSDictionary *menuItem2 = @{ @"title": @"Menu Item 2",
                                 @"iconName": @"testImage",
                                 @"featureName": @"feature2",
                                 @"tapEventHandler": @"TestEventHandler2"
                                 };
    
    return @[menuItem1, menuItem2];
}

@end
