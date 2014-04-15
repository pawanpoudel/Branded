//
//  CCHMenuViewController.m
//  Branded
//
//  Created by PAWAN POUDEL on 4/14/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

#import "CCHMenuViewController.h"
#import "ECSlidingViewController.h"
#import "CCHSlidingNavigationController.h"
#import "CCHMenuTableDataSource.h"
#import "CCHMenuItem.h"

@interface CCHMenuViewController ()

@property (weak, nonatomic) IBOutlet UITableView *menuTableView;

@end

@implementation CCHMenuViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.slidingViewController setAnchorRightRevealAmount:280.0f];
    self.slidingViewController.underLeftWidthLayout = ECFullWidth;
    
    self.menuTableView.dataSource = self.dataSource;
    self.menuTableView.delegate = self.dataSource;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(userDidSelectMenuItemNotification:)
                                                 name:CCHMenuTableDataSourceDidSelectItemNotification
                                               object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:CCHMenuTableDataSourceDidSelectItemNotification
                                                  object:nil];
}

#pragma mark - Actions

- (void)reload {
    [self.menuTableView reloadData];
}

#pragma mark - Notification handling

- (void)userDidSelectMenuItemNotification:(NSNotification *)notification {
    CCHMenuItem *menuItem = [notification object];
    Class tapEventHandlerClass = NSClassFromString(menuItem.tapEventHandlerClassName);
    
    if (tapEventHandlerClass) {
        NSObject *tapEventHandler = [[tapEventHandlerClass alloc] init];
        
        if ([tapEventHandler isKindOfClass:[UIViewController class]]) {
            [self slideInTopViewController:(UIViewController *)tapEventHandler];
        }
        else {
            [self showAlert];
        }
    }
}

- (void)slideInTopViewController:(UIViewController *)topViewController {
    CCHSlidingNavigationController *newTopNavController = [[CCHSlidingNavigationController alloc]
                                                          initWithRootViewController:topViewController];
    
    [self.slidingViewController anchorTopViewOffScreenTo:ECRight
                                              animations:nil
                                              onComplete:^{
                                                  CGRect frame = self.slidingViewController.topViewController.view.frame;
                                                  self.slidingViewController.topViewController = newTopNavController;
                                                  self.slidingViewController.topViewController.view.frame = frame;
                                                  [self.slidingViewController resetTopView];
                                              }];
}

- (void)showAlert {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Menu item tapped"
                                                    message:@""
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
