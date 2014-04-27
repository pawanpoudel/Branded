//
//  CCHAppSetting.h
//  Branded
//
//  Created by PAWAN POUDEL on 4/14/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

@interface CCHAppSetting : NSObject

/*!
    @description Returns a shared instance of CCHAppSetting.
    @discussion  Call this method instead of @ainitWithSettings:
                 if you need the same instance that was created
                 before. This method reads a dictionary of settings
                 specified in @aappSetting.plist file.
 */
+ (instancetype)sharedInstance;

/*!
    @description Creates and returns a new CCHAppSetting object.
    @param settings A dictionary of app settings.
    @return A new CCHAppSetting object.
 */
- (instancetype)initWithSettings:(NSDictionary *)settings;

/*!
    @description Returns a host.
    @discussion Normally a host is same as the domain name, but
                sometimes it could also be a literal IP address.
    @return A NSString object containing the host name.
 */
- (NSString *)host;

/*!
    @description Returns the root URL for the app.
    @see apiRootURL
    @return A NSURL object containing the root URL info.
 */
- (NSURL *)rootURL;

/*!
    @description Returns the root API URL for the app.
    @discussion This is not the same as the root URL.
    @see rootURL
    @return A NSURL object containing the root API URL
            info.
 */
- (NSURL *)apiRootURL;

@end
