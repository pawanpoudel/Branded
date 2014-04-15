//
//  CCHAppSetting.h
//  Branded
//
//  Created by PAWAN POUDEL on 4/14/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

@interface CCHAppSetting : NSObject

+ (instancetype)sharedInstance;
- (instancetype)initWithDictionary:(NSDictionary *)settings;

- (NSString *)host;
- (NSURL *)rootURL;
- (NSURL *)apiRootURL;

@end
