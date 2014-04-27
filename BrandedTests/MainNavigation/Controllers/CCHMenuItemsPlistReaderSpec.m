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
    it(@"conforms to CCHMenuItemsReader protocol", ^{
        CCHMenuItemsPlistReader *menuPlistReader = [[CCHMenuItemsPlistReader alloc] init];
        [[menuPlistReader should] conformToProtocol:@protocol(CCHMenuItemsReader)];
    });
});

SPEC_END