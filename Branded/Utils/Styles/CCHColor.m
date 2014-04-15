//
//  CCHColor.m
//  Branded
//
//  Created by PAWAN POUDEL on 4/14/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

#import "CCHColor.h"

static NSDictionary *_colors = nil;

@interface CCHColor()
+ (NSDictionary *)colors;
@end

@implementation CCHColor

#pragma mark - Accessors

+ (NSDictionary *)colors {
    if (_colors == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"colors"
                                                         ofType:@"plist"];
        
        _colors = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    return _colors;
}

#pragma mark - Generic

+ (UIColor *)appColor {
    NSString *hexColorValue = [self colors][@"appColor"];
    return [CCHColor colorWithHex:hexColorValue];
}

#pragma mark - Navigation items

+ (UIColor *)navBarTintColor {
    return [UIColor whiteColor];
}

#pragma mark - Table view

+ (UIColor *)mainMenuBackgroundColor {
    return [CCHColor colorWithHex:@"0x141B1F"];
}

#pragma mark - Color conversion methods

+ (UIColor *)colorWithHex:(NSString *)hexValue {
    unsigned colorInt = 0;
    [[NSScanner scannerWithString:hexValue] scanHexInt:&colorInt];
    
    CGFloat red = (CGFloat)((colorInt & 0xFF0000) >> 16);
    CGFloat green = (CGFloat)((colorInt & 0xFF00) >> 8);
    CGFloat blue = (CGFloat)(colorInt & 0xFF);
    
    return [self colorWithRed:red
                        green:green
                         blue:blue];
}

+ (UIColor *)colorWithRed:(CGFloat)red
                    green:(CGFloat)green
                     blue:(CGFloat)blue
{
    return [self colorWithRed:red
                        green:green
                         blue:blue
                        alpha:1.0];
}

+ (UIColor *)colorWithRed:(CGFloat)red
                    green:(CGFloat)green
                     blue:(CGFloat)blue
                    alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:red/255.0f
                           green:green/255.0f
                            blue:blue/255.0f
                           alpha:alpha];
}

+ (NSString *)cssColorWithUIColor:(UIColor *)color {
    CGFloat redFloat, greenFloat, blueFloat;
    
    [color getRed:&redFloat
            green:&greenFloat
             blue:&blueFloat
            alpha:NULL];
    
    int redInt, greenInt, blueInt;
    
    redInt = (int)(redFloat * 255.0f);
    greenInt = (int)(greenFloat * 255.0f);
    blueInt = (int)(blueFloat * 255.0f);
    
    return [NSString stringWithFormat:@"#%02x%02x%02x", redInt, greenInt, blueInt];
}

@end
