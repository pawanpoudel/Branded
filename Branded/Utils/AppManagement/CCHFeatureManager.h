//
//  CCHFeatureManager.h
//  Branded
//
//  Created by PAWAN POUDEL on 4/14/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

@interface CCHFeatureManager : NSObject

/*!
    @description Get a complete list of features that are enabled
                 for the application.
 */
@property (readonly, nonatomic) NSArray *features;

/*!
    @description Returns a shared instance of CCHFeatureManager.
    @discussion  Call this method instead of @ainitWithFeatures:
                 if you need the same instance that was created
                 before. This method reads a list of features
                 specified in @afeatures.plist file.
 */
+ (instancetype)sharedInstance;

/*!
    @description Creates and returns a new CCHFeatureManager object.
    @param features An array of enabled features.
    @return A new CCHFeatureManager object.
 */
- (instancetype)initWithFeatures:(NSArray *)features;

/*!
    @description Check the list of features to see if profile
                 is enabled or not.
    @return YES if diagnostics is enabled otherwise NO.
 */
- (BOOL)isProfileEnabled;

/*!
    @description Check the list of features to see if settings
                 is enabled or not.
    @return YES if backups is enabled otherwise NO.
 */
- (BOOL)isSettingsEnabled;

/*!
    @description Check the list of features to see if home
                 is enabled or not.
    @return YES if locate is enabled otherwise NO.
 */
- (BOOL)isHomeEnabled;

@end