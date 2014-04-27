//
//  CCHMenuItemsPlistReader.m
//  Branded
//
//  Created by PAWAN POUDEL on 4/26/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

#import "CCHMenuItemsPlistReader.h"

@implementation CCHMenuItemsPlistReader

- (NSArray *)readMenuItems {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:self.plistToReadFrom
                                                         ofType:@"plist"];
    return [NSArray arrayWithContentsOfFile:filePath];
}

@end
