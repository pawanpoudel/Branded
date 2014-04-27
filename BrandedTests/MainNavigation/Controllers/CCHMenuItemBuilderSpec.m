//
//  CCHMenuItemBuilderSpec.m
//  Branded
//
//  Created by PAWAN POUDEL on 4/27/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

#import "Kiwi.h"
#import "CCHMenuItemBuilder.h"
#import "CCHFakeMenuItemsReader.h"
#import "CCHMenuItem.h"

SPEC_BEGIN(CCHMenuItemBuilderSpec)

describe(@"CCHMenuItemBuilder", ^{
    
    CCHMenuItemBuilder __block *menuItemBuilder = nil;
    NSArray __block *rawMenuItems = nil;
    NSArray __block *menuItems = nil;
    NSArray __block *enabledFeatures = nil;
    
    beforeEach(^{        
        CCHFakeMenuItemsReader *fakeMenuReader = [[CCHFakeMenuItemsReader alloc] init];
        menuItemBuilder = [[CCHMenuItemBuilder alloc] init];
        [menuItemBuilder setMenuReader:fakeMenuReader];
        
        rawMenuItems = [fakeMenuReader readMenuItems];
        enabledFeatures = @[@"feature1", @"feature2"];
        menuItems = [menuItemBuilder menuItemsForEnabledFeatures:enabledFeatures];
    });
    
    it(@"returns one menu item object for each raw menu item dictionary", ^{
        [[theValue([menuItems count]) should] equal:theValue([rawMenuItems count])];
    });
    
    it(@"returns menu item whose properties contain values present in raw dictionary", ^{
        NSDictionary *rawMenuItem = rawMenuItems[0];
        CCHMenuItem *menuItem = menuItems[0];
        
        [[menuItem.title should] equal:rawMenuItem[@"title"]];
        [[menuItem.subTitle should] equal:rawMenuItem[@"subTitle"]];
        [[menuItem.featureName should] equal:rawMenuItem[@"featureName"]];
        [[theValue(menuItem.rowHeight) should] equal:theValue([rawMenuItem[@"rowHeight"] floatValue])];
        [[menuItem.tapEventHandlerClassName should] equal:rawMenuItem[@"tapEventHandler"]];
    });
    
    it(@"returns menu items for enabled features only", ^{
        enabledFeatures = @[@"feature1"];
        menuItems = [menuItemBuilder menuItemsForEnabledFeatures:enabledFeatures];
        CCHMenuItem *menuItem = menuItems[0];
        
        [[theValue([menuItems count]) should] equal:theValue([enabledFeatures count])];
        [[menuItem.featureName should] equal:@"feature1"];
    });
});

SPEC_END
