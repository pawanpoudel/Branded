//
//  CCHMenuTableDataSource.h
//  Branded
//
//  Created by PAWAN POUDEL on 4/14/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

extern NSString *const CCHMenuTableDataSourceDidSelectItemNotification;

@interface CCHMenuTableDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

- (void)setMenuItems:(NSArray *)menuItems;

@end
