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
    NSString const *scheme = @"https";
    NSString const *host = @"subdomain.domain.com";
    
    let(settingsDict, nil);
    let(appSetting, ^{ return [[CCHAppSetting alloc] initWithSettings:settingsDict]; });
    
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
    
    describe(@".rootURL", ^{
        context(@"with scheme and host", ^{
            context(@"with port", ^{
                NSString const *port = @"443";                
                let(settingsDict, ^{ return @{@"urlComponents": @{@"scheme": scheme, @"host": host, @"port": port}}; });
                let(expected, ^{ return [NSString stringWithFormat:@"%@://%@:%@", scheme, host, port]; });
                
                it(@"constructs the full URL correctly", ^{
                    [[[[appSetting rootURL] absoluteString] should] equal:expected];
                });
            });
            
            context(@"without port", ^{
                let(settingsDict, ^{ return @{@"urlComponents": @{@"scheme": scheme, @"host": host}}; });
                let(expected, ^{ return [NSString stringWithFormat:@"%@://%@", scheme, host]; });
                
                it(@"constructs the full URL correctly", ^{
                    [[[[appSetting rootURL] absoluteString] should] equal:expected];
                });
            });
        });
    });
    
    describe(@".apiRootURL", ^{
        NSString const *apiEndPoint = @"api/v5";
        let(expected, ^{ return [NSString stringWithFormat:@"%@://%@/%@", scheme, host, apiEndPoint]; });
        
        context(@"with leading slash", ^{
            let(settingsDict, ^{ return @{@"urlComponents": @{@"scheme": scheme, @"host": host, @"apiEndPoint": [NSString stringWithFormat:@"/%@", apiEndPoint]}}; });
            
            it(@"constructs the full API root URL correctly", ^{
                [[[[appSetting apiRootURL] absoluteString] should] equal:expected];
            });
        });
        
        context(@"without leading slash", ^{
            let(settingsDict, ^{ return @{@"urlComponents": @{@"scheme": scheme, @"host": host, @"apiEndPoint": apiEndPoint}}; });
            
            it(@"constructs the full API root URL correctly", ^{
                [[[[appSetting apiRootURL] absoluteString] should] equal:expected];
            });
        });
    });
});

SPEC_END