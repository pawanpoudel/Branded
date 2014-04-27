//
//  CCHMenuItemsPlistReader.h
//  Branded
//
//  Created by PAWAN POUDEL on 4/26/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

#import "CCHMenuItemsReader.h"

/*!
    @description Read menu items metadata from the specified plist.
    @discussion This class conforms to CCHMenuItemsReader protocol.
 */

@interface CCHMenuItemsPlistReader : NSObject <CCHMenuItemsReader>

/*!
    @description A NSString object that contains the name of the
                 plist file to read menu items metadata from.
 */
@property (nonatomic) NSString *plistToReadFrom;

@end
