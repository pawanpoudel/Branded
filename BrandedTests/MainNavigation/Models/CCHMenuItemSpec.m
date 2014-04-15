//
//  CCHMenuItemSpec.m
//  Branded
//
//  Created by PAWAN POUDEL on 4/15/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

#import "Kiwi.h"
#import "CCHMenuItem.h"

SPEC_BEGIN(CCHMenuItemSpec)

describe(@"CCHMenuItem", ^{
    
    let(menuItem, ^{ return [[CCHMenuItem alloc] init]; });
    
    it(@"can be assigned a title", ^{
        NSString *title = @"My iPhone";
        [menuItem setTitle:title];
        [[[menuItem title] should] equal:title];
    });
    
    it(@"can be assigned a subtitle", ^{
        NSString *subTitle = @"Tap to view your profile";
        [menuItem setSubTitle:subTitle];
        [[[menuItem subTitle] should] equal:subTitle];
    });
    
    it(@"can be assigned an icon", ^{
        UIImage *icon = [UIImage imageNamed:@"testImage"];
        [menuItem setIcon:icon];
        [[[menuItem icon] should] equal:icon];
    });
    
    it(@"can be assigned a background image", ^{
        UIImage *backgroundImage = [UIImage imageNamed:@"testImage"];
        [menuItem setBackgroundImage:backgroundImage];
        [[[menuItem backgroundImage] should] equal:backgroundImage];
    });
    
    it(@"can be assigned a row height", ^{
        CGFloat rowHeight = 40.0f;
        [menuItem setRowHeight:rowHeight];
        [[theValue([menuItem rowHeight]) should] equal:theValue(rowHeight)];
    });
    
    it(@"can be assigned a tap event handler", ^{
        NSString *eventHandlerClassName = @"EventHandler";
        [menuItem setTapEventHandlerClassName:eventHandlerClassName];
        [[[menuItem tapEventHandlerClassName] should] equal:eventHandlerClassName];
    });
    
    it(@"can be assigned a feature name", ^{
        NSString *featureName = @"locate";
        [menuItem setFeatureName:featureName];
        [[[menuItem featureName] should] equal:featureName];
    });
});

SPEC_END
