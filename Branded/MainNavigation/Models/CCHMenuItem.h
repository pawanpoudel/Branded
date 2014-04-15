//
//  CCHMenuItem.h
//  Branded
//
//  Created by PAWAN POUDEL on 4/14/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

@interface CCHMenuItem : NSObject

/*!
    @description A name for this menu item, suitable for displaying in the UI.
 */
@property (nonatomic) NSString *title;

/*!
    @description Text to display below the title.
 */
@property (nonatomic) NSString *subTitle;

/*!
    @description Icon to display next to the title.
 */
@property (nonatomic) UIImage *icon;

/*!
    @description Background image for the view that displays this menu item.
 */
@property (nonatomic) UIImage *backgroundImage;

/*!
    @description Height for the row that will display this menu item.
 */
@property (nonatomic) CGFloat rowHeight;

/*!
    @description Event handler's class name.
 */
@property (nonatomic) NSString *tapEventHandlerClassName;

/*!
    @description The name of the feature this menu item represents.
 */
@property (nonatomic) NSString *featureName;

@end
