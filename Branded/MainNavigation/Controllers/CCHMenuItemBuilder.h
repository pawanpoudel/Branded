//
//  CCHMenuItemBuilder.h
//  Branded
//
//  Created by PAWAN POUDEL on 4/26/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

#import "CCHMenuItemsReader.h"

@interface CCHMenuItemBuilder : NSObject

- (void)setMenuReader:(id<CCHMenuItemsReader>)menuReader;
- (NSArray *)menuItemsForEnabledFeatures:(NSArray *)features;

@end
