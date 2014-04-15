//
//  UIImage+Helper.m
//  Branded
//
//  Created by PAWAN POUDEL on 4/14/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

#import "UIImage+Helper.h"

@implementation UIImage (Helper)

- (UIImage *)thumbnailWithSize:(CGSize)size {
    CGSize originalImageSize = [self size];
    CGRect newRect = CGRectMake(0, 0, size.width, size.height);
    
    float ratio = MAX(newRect.size.width / originalImageSize.width,
                      newRect.size.height / originalImageSize.height);
    
    UIGraphicsBeginImageContextWithOptions(newRect.size, NO, 0.0);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:newRect cornerRadius:5.0];
    [path addClip];
    
    CGRect projectRect;
    projectRect.size.width = ratio * originalImageSize.width;
    projectRect.size.height = ratio * originalImageSize.height;
    projectRect.origin.x = (newRect.size.width - projectRect.size.width) / 2.0;
    projectRect.origin.y = (newRect.size.height - projectRect.size.height) / 2.0;
    
    [self drawInRect:projectRect];
    
    UIImage *thumbnail = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return thumbnail;
}

@end
