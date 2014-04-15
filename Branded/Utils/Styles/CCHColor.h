//
//  CCHColor.h
//  Branded
//
//  Created by PAWAN POUDEL on 4/14/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

@interface CCHColor : NSObject

#pragma mark - Generic

/*!
    @description Returns main color for the application. Instead of hard-coding
                 color values throughout the code base, this method should be
                 called to apply the color that is subject to change between
                 different targets.
    @return A UIColor object.
 */
+ (UIColor *)appColor;

#pragma mark - Navigation items

/*!
    @description Returns tint color that should be applied to all navigation bars.
    @return A UIColor object.
 */
+ (UIColor *)navBarTintColor;

#pragma mark - Table view

/*!
    @description Returns background color for the main application menu view.
    @return A UIColor object.
 */
+ (UIColor *)mainMenuBackgroundColor;

#pragma mark - Color conversion methods

/*!
    @description Creates and returns a UIColor object using the specified hex color string.
    @param hexValue The color value in hex format (e.g., 0x686868)
    @return A UIColor object.
 */
+ (UIColor *)colorWithHex:(NSString *)hexValue;

/*!
    @description Creates and returns a UIColor object using the specified RGB 
                 component values. Defaults alpha value (opacity) to 1.0.
    @param red The red component of the color object, specified as a value from 0.0 to 255.0.
    @param green The green component of the color object, specified as a value from 0.0 to 255.0.
    @param blue The blue component of the color object, specified as a value from 0.0 to 255.0.
    @return A UIColor object.
 */
+ (UIColor *)colorWithRed:(CGFloat)red
                    green:(CGFloat)green
                     blue:(CGFloat)blue;

/*!
    @description Creates and returns a UIColor object using the specified RGB
                 component values and opacity.
    @param red The red component of the color object, specified as a value from 0.0 to 255.0.
    @param green The green component of the color object, specified as a value from 0.0 to 255.0.
    @param blue The blue component of the color object, specified as a value from 0.0 to 255.0.
    @param alpha The opacity value of the color object, specified as a value from 0.0 and 1.0.
    @return A UIColor object.
 */
+ (UIColor *)colorWithRed:(CGFloat)red
                    green:(CGFloat)green
                     blue:(CGFloat)blue
                    alpha:(CGFloat)alpha;

/*!
    @description Creates and returns a hex color string meant to be used in CSS using the 
                 specified UIColor instance.
    @param color A UIColor instance.
    @return A NSString object that represents color in hex format (#. The string includes '#' symbol,
            for example, #686868.
 */
+ (NSString *)cssColorWithUIColor:(UIColor *)color;

@end
