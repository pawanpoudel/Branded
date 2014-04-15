//
//  CCHFeatureManager.m
//  Branded
//
//  Created by PAWAN POUDEL on 4/14/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

#import "CCHFeatureManager.h"

@interface CCHFeatureManager()

@property (readwrite, nonatomic) NSArray *features;

@end

@implementation CCHFeatureManager

+ (instancetype)sharedInstance {
    static CCHFeatureManager *featureManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        NSString *path = [[NSBundle mainBundle] pathForResource:@"features"
                                                         ofType:@"plist"];
        NSArray *features = [NSArray arrayWithContentsOfFile:path];
        featureManager = [[self alloc] initWithFeatures:features];
    });
    
    return featureManager;
}

- (instancetype)initWithFeatures:(NSArray *)features {
    self = [super init];
    if (self) {
        _features = features;
    }
    
    return self;
}

- (BOOL)isProfileEnabled {
    return [self.features containsObject:@"profile"];
}

- (BOOL)isHomeEnabled {
    return [self.features containsObject:@"home"];
}

- (BOOL)isSettingsEnabled {
    return [self.features containsObject:@"settings"];
}

@end
