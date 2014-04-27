//
//  CCHMenuItemsReader.h
//  Branded
//
//  Created by PAWAN POUDEL on 4/26/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

/*!
    @description Defines methods that a menu items reader object
                 must implement.
 */
@protocol CCHMenuItemsReader <NSObject>

/*!
    @description Read menu items metadata. The source could be
                 anything including a plist file or a remote server.
    @discussion All menu items reader objects that wish to conform to
                CCHMenuItemsReader protocol, must implement this method.
    @return An NSArray object containing a list of NSDictionary objects
            that represent the metadata for each menu item.
 */
- (NSArray *)readMenuItems;

@end
