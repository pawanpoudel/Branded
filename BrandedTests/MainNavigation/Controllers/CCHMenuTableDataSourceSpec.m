//
//  CCHMenuTableDataSourceSpec.m
//  Branded
//
//  Created by PAWAN POUDEL on 4/15/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

#import "Kiwi.h"
#import "CCHMenuTableDataSource.h"
#import "CCHMenuItem.h"

SPEC_BEGIN(CCHMenuTableDataSourceSpec)

describe(@"CCHMenuTableDataSource", ^{
    
    CCHMenuTableDataSource __block *dataSource = nil;
    NSArray __block *menuItemsList = nil;
    CCHMenuItem __block *sampleMenuItem = nil;
    
    beforeEach(^{
        dataSource = [[CCHMenuTableDataSource alloc] init];
        
        sampleMenuItem = [[CCHMenuItem alloc] init];
        sampleMenuItem.title = @"Sample menu item";
        
        menuItemsList = @[sampleMenuItem];
        [dataSource setMenuItems:menuItemsList];
    });
    
    it(@"returns one table row for one menu item", ^{
        NSInteger actualNumberOfRows = [dataSource tableView:nil numberOfRowsInSection:0];
        NSInteger expectedNumberOfRows = [menuItemsList count];
        
        [[theValue(actualNumberOfRows) should] equal:theValue(expectedNumberOfRows)];
    });
    
    it(@"returns two table rows for two menu items", ^{
        CCHMenuItem *menuItem1 = [[CCHMenuItem alloc] init];
        menuItem1.title = @"Menu item 1";
        
        CCHMenuItem *menuItem2 = [[CCHMenuItem alloc] init];
        menuItem2.title = @"Menu item 2";
        
        NSArray *twoMenuItems = @[menuItem1, menuItem2];
        [dataSource setMenuItems:twoMenuItems];

        NSInteger actualNumberOfRows = [dataSource tableView:nil numberOfRowsInSection:0];
        NSInteger expectedNumberOfRows = [twoMenuItems count];
        
        [[theValue(actualNumberOfRows) should] equal:theValue(expectedNumberOfRows)];
    });
    
    it(@"returns only one section", ^{
        [[theBlock(^{
            [dataSource tableView:nil numberOfRowsInSection:1];
        }) should] raise];
    });
    
    it(@"will not prepare cells for unexpected sections", ^{
        NSIndexPath *secondSection = [NSIndexPath indexPathForRow:0
                                                        inSection:1];
        [[theBlock(^{
            [dataSource tableView:nil cellForRowAtIndexPath:secondSection];
        }) should] raise];
    });
    
    it(@"will not create more cells than there are menu items", ^{
        NSIndexPath *afterLastMenuItem = [NSIndexPath indexPathForRow:[menuItemsList count]
                                                            inSection:0];
        [[theBlock(^{
            [dataSource tableView:nil cellForRowAtIndexPath:afterLastMenuItem];
        }) should] raise];
    });
    
    it(@"creates cell containing menu item title as text label", ^{
        NSIndexPath *firstMenuItemIndex = [NSIndexPath indexPathForRow:0
                                                        inSection:0];
        
        UITableViewCell *firstCell = [dataSource tableView:nil
                                     cellForRowAtIndexPath:firstMenuItemIndex];
        
        NSString *cellTitle = firstCell.textLabel.text;
        [[cellTitle should] equal:sampleMenuItem.title];
    });
});

SPEC_END