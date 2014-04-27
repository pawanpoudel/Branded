//
//  CCHAppSetting.m
//  Branded
//
//  Created by PAWAN POUDEL on 4/14/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

#import "CCHAppSetting.h"

@interface CCHAppSetting()
@property (nonatomic) NSDictionary *settings;
@end

@implementation CCHAppSetting

+ (instancetype)sharedInstance {
    static CCHAppSetting *appSetting = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        NSString *path = [[NSBundle mainBundle] pathForResource:@"appSetting"
                                                         ofType:@"plist"];
        
        NSDictionary *setting = [NSDictionary dictionaryWithContentsOfFile:path];
        appSetting = [[self alloc] initWithSettings:setting];
    });
    
    return appSetting;
}

- (instancetype)initWithSettings:(NSDictionary *)settings {
    self = [super init];
    if (self) {
        self.settings = settings;
    }
    return self;
}

- (NSString *)host {
    return self.settings[@"urlComponents"][@"host"];
}

- (NSURL *)rootURL {
    NSDictionary *components = self.settings[@"urlComponents"];
    
    NSMutableString *rootURL = [NSMutableString stringWithFormat:@"%@://%@",
                                components[@"scheme"],
                                components[@"host"]];
    
    NSString *port = components[@"port"];
    if (IsNotEmpty(port)) {
        [rootURL appendFormat:@":%@", port];
    }
    
    return [NSURL URLWithString:rootURL];
}

- (NSURL *)apiRootURL {
    NSString *endpoint = self.settings[@"urlComponents"][@"apiEndPoint"];
    return [NSURL URLWithString:endpoint relativeToURL:[self rootURL]];
}

@end

