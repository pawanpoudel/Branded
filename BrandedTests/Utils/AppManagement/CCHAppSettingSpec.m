//
//  CCHAppSettingSpec.m
//  Branded
//
//  Created by PAWAN POUDEL on 4/26/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

#import "Kiwi.h"
#import "CCHAppSetting.h"

SPEC_BEGIN(CCHAppSettingSpec)

describe(@"CCHAppSetting", ^{
    describe(@"#sharedInstance", ^{
        it(@"returns the same instance", ^{
            CCHAppSetting *appSetting1 = [CCHAppSetting sharedInstance];
            CCHAppSetting *appSetting2 = [CCHAppSetting sharedInstance];
            [[appSetting1 should] beIdenticalTo:appSetting2];
        });
    });
    
    describe(@".initWithSettings:", ^{
        it(@"returns a new instance each time", ^{
            CCHAppSetting *appSetting1 = [[CCHAppSetting alloc] initWithSettings:nil];
            CCHAppSetting *appSetting2 = [[CCHAppSetting alloc] initWithSettings:nil];
            [[appSetting1 shouldNot] beIdenticalTo:appSetting2];
        });
    });
});

SPEC_END