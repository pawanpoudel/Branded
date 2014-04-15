//
//  CCHFeatureManagerSpec.m
//  Branded
//
//  Created by PAWAN POUDEL on 4/15/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

#import "Kiwi.h"
#import "CCHFeatureManager.h"

SPEC_BEGIN(CCHFeatureManagerSpec)

describe(@"CCHFeatureManager", ^{
    
    let(features, nil);
    let(emptyFeaturesList, ^{ return @[]; });
    let(featureManager, ^{ return [[CCHFeatureManager alloc] initWithFeatures:features]; });
    
    describe(@"#sharedInstance", ^{
        it(@"returns the same instance", ^{
            CCHFeatureManager *firstFeatureManager = [CCHFeatureManager sharedInstance];
            CCHFeatureManager *secondFeatureManager = [CCHFeatureManager sharedInstance];
            [[firstFeatureManager should] beIdenticalTo:secondFeatureManager];
        });
    });
    
    describe(@".initWithFeatures:", ^{
        it(@"returns a new instance each time", ^{
            CCHFeatureManager *firstFeatureManager = [[CCHFeatureManager alloc] initWithFeatures:nil];
            CCHFeatureManager *secondFeatureManager = [[CCHFeatureManager alloc] initWithFeatures:nil];
            [[firstFeatureManager shouldNot] beIdenticalTo:secondFeatureManager];
        });
    });
    
    describe(@".features", ^{
        it(@"returns a list of enabled features", ^{
            NSArray *enabledFeatures = @[@"locate", @"backups", @"troubleshooting", @"news"];
            CCHFeatureManager *featureManager = [[CCHFeatureManager alloc] initWithFeatures:enabledFeatures];
            [[[featureManager features] should] equal:enabledFeatures];
        });
    });
    
    describe(@".isProfileEnabled", ^{
        context(@"with profile enabled", ^{
            let(features, ^{ return @[@"profile"]; });
            
            it(@"returns YES", ^{
                [[theValue([featureManager isProfileEnabled]) should] equal:theValue(YES)];
            });
        });
        
        context(@"with profile disabled", ^{
            let(features, emptyFeaturesList);
            
            it(@"returns NO", ^{
                [[theValue([featureManager isProfileEnabled]) should] equal:theValue(NO)];
            });
        });
    });
    
    describe(@".isHomeEnabled", ^{
        context(@"with home enabled", ^{
            let(features, ^{ return @[@"home"]; });
            
            it(@"returns YES", ^{
                [[theValue([featureManager isHomeEnabled]) should] equal:theValue(YES)];
            });
        });
        
        context(@"with home disabled", ^{
            let(features, emptyFeaturesList);
            
            it(@"returns NO", ^{
                [[theValue([featureManager isHomeEnabled]) should] equal:theValue(NO)];
            });
        });
    });
    
    describe(@".isSettingsEnabled", ^{
        context(@"with settings enabled", ^{
            let(features, ^{ return @[@"settings"]; });
            
            it(@"returns YES", ^{
                [[theValue([featureManager isSettingsEnabled]) should] equal:theValue(YES)];
            });
        });
        
        context(@"with settings disabled", ^{
            let(features, emptyFeaturesList);
            
            it(@"returns NO", ^{
                [[theValue([featureManager isSettingsEnabled]) should] equal:theValue(NO)];
            });
        });
    });
});

SPEC_END
