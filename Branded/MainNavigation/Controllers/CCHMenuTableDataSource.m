//
//  CCHMenuTableDataSource.m
//  Branded
//
//  Created by PAWAN POUDEL on 4/14/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

#import "CCHMenuTableDataSource.h"
#import "CCHMenuItem.h"

NSString *const CCHMenuTableDataSourceDidSelectItemNotification = @"CCHMenuTableDataSourceDidSelectItemNotification";

@interface CCHMenuTableDataSource()

@property (nonatomic) NSArray *menuItems;

@end

@implementation CCHMenuTableDataSource

#pragma mark - Accessors

- (void)setMenuItems:(NSArray *)menuItems {
    _menuItems = menuItems;
}

#pragma mark - Table view methods

- (CCHMenuItem *)menuItemForIndexPath:(NSIndexPath *)indexPath {
    return self.menuItems[indexPath.row];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)sectionIndex
{
    NSParameterAssert(sectionIndex == 0);
    return self.menuItems.count;
}

- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CCHMenuItem *menuItem = [self menuItemForIndexPath:indexPath];
    if (menuItem.rowHeight) {
        return menuItem.rowHeight;
    }
    
    UIImage *backgroundImage = [UIImage imageNamed:@"bgMenuCell.png"];
    return backgroundImage.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSParameterAssert(indexPath.section == 0);
    NSParameterAssert(indexPath.row < [self.menuItems count]);
    
    NSString *cellIdentifier = @"MenuItemCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdentifier];
    }
    
    return [self configureCell:cell
                   atIndexPath:indexPath];
}

- (UITableViewCell *)configureCell:(UITableViewCell *)cell
                       atIndexPath:(NSIndexPath *)indexPath
{
    [self setMenuIconsForCell:cell
                  atIndexPath:indexPath];
    
    [self setBackgroundImageForCell:cell
                        atIndexPath:indexPath];
    
    [self setTextForCell:cell
             atIndexPath:indexPath];
  
    return cell;
}

- (void)setMenuIconsForCell:(UITableViewCell *)cell
                atIndexPath:(NSIndexPath *)indexPath
{
    CCHMenuItem *menuItem = [self menuItemForIndexPath:indexPath];
    cell.imageView.image = menuItem.icon;
}

- (void)setBackgroundImageForCell:(UITableViewCell *)cell
                      atIndexPath:(NSIndexPath *)indexPath
{
    CCHMenuItem *menuItem = [self menuItemForIndexPath:indexPath];
    if (menuItem.backgroundImage) {
        cell.backgroundView = [[UIImageView alloc] initWithImage:menuItem.backgroundImage];
    }
    
    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgMenuCellHighlighted.png"]];
}

- (void)setTextForCell:(UITableViewCell *)cell
           atIndexPath:(NSIndexPath *)indexPath
{
    CCHMenuItem *menuItem = [self menuItemForIndexPath:indexPath];
    
    cell.textLabel.text = menuItem.title;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.highlightedTextColor = [CCHColor appColor];
    
    cell.detailTextLabel.text = menuItem.subTitle;
    cell.detailTextLabel.textColor = [UIColor whiteColor];
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[CCHColor mainMenuBackgroundColor]];
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNotification *notification = [NSNotification notificationWithName:CCHMenuTableDataSourceDidSelectItemNotification
                                                                 object:[self menuItemForIndexPath:indexPath]];
    
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

@end
