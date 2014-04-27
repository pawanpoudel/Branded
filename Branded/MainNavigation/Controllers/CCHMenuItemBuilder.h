//
//  CCHMenuItemBuilder.h
//  Branded
//
//  Created by PAWAN POUDEL on 4/26/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

#import "CCHMenuItemsReader.h"

/*!
    @description Construct @aCCHMenuItem objects from enabled features
    @see CCHMenuItem
 */
@interface CCHMenuItemBuilder : NSObject

/*!
    @description Sets a menu items reader object.
    @param menuReader An object that knows how to read menu items
           metadata. It must conform to @aCCHMenuItemsReader protocol.
 */
- (void)setMenuReader:(id<CCHMenuItemsReader>)menuReader;

/*!
    @description Given an array containing features that are enabled in
                 the application, returns a list of @aCCHMenuItem objects.
    @param features An array of enabled features
    @return An array of @aCCHMenuItem objects.
 */
- (NSArray *)menuItemsForEnabledFeatures:(NSArray *)features;

@end
