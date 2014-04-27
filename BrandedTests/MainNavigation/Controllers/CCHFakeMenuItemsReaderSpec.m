//
//  CCHFakeMenuItemsReaderSpec.m
//  Branded
//
//  Created by PAWAN POUDEL on 4/26/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

#import "Kiwi.h"
#import "CCHFakeMenuItemsReader.h"

SPEC_BEGIN(CCHFakeMenuItemsReaderSpec)

describe(@"CCHFakeMenuItemsReader", ^{
    it(@"conforms to CCHMenuItemsReader protocol", ^{
        CCHFakeMenuItemsReader *fakeMenuReader = [[CCHFakeMenuItemsReader alloc] init];
        [[fakeMenuReader should] conformToProtocol:@protocol(CCHMenuItemsReader)];
    });
});

SPEC_END
