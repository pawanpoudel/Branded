//
//  CCHMenuItemsPlistReaderSpec.m
//  Branded
//
//  Created by PAWAN POUDEL on 4/26/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

#import "Kiwi.h"
#import "CCHMenuItemsPlistReader.h"

SPEC_BEGIN(CCHMenuItemsPlistReaderSpec)

describe(@"CCHMenuItemsPlistReader", ^{
    CCHMenuItemsPlistReader __block *menuPlistReader = nil;
    NSString __block *testPlistToReadFrom = nil;
    
    beforeEach(^{
        menuPlistReader = [[CCHMenuItemsPlistReader alloc] init];
        testPlistToReadFrom = @"testMenuItems.plist";
        menuPlistReader.plistToReadFrom = testPlistToReadFrom;
    });
    
    it(@"conforms to MDMenuReader protocol", ^{
        [[menuPlistReader should] conformToProtocol:@protocol(CCHMenuItemsReader)];
    });
    
    it(@"reads given file's full path in app bundle", ^{
        id mockNSBundle = [NSBundle nullMock];
        [NSBundle stub:@selector(mainBundle)
             andReturn:mockNSBundle];
        
        [[[mockNSBundle should] receive] pathForResource:testPlistToReadFrom
                                                  ofType:@"plist"];
        [menuPlistReader readMenuItems];
    });
    
    it(@"creates and returns an array of menu items from given plist", ^{
        id mockNSBundle = [NSBundle nullMock];
        [NSBundle stub:@selector(mainBundle)
             andReturn:mockNSBundle];
        
        NSString *testPlistFilePath = @"/path/to/testMenuItems.plist";
        [mockNSBundle stub:@selector(pathForResource:ofType:)
                 andReturn:testPlistFilePath];
        
        NSDictionary *testMenuItem = @{ @"title": @"Test Menu Item" };
        NSArray *expectedRawMenuItemsArray = @[testMenuItem];
        
        [[NSArray should] receive:@selector(arrayWithContentsOfFile:)
                        andReturn:expectedRawMenuItemsArray
                    withArguments:testPlistFilePath];
        
        [[[menuPlistReader readMenuItems] should] equal:expectedRawMenuItemsArray];
    });
});

SPEC_END
