//
//  CCHSettingsViewController.m
//  Branded
//
//  Created by PAWAN POUDEL on 4/14/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

#import "CCHSettingsViewController.h"
#import "ECSlidingViewController.h"

@implementation CCHSettingsViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureNavigationBar];
}

- (void)configureNavigationBar {
    [self addMenuButton];
    self.title = @"Settings";
}

- (void)addMenuButton {
    UIImage *navImage = [UIImage imageNamed:@"iconNav.png"];
    UIButton *navButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [navButton setImage:navImage
               forState:UIControlStateNormal];
    
    navButton.frame = CGRectMake(0, 0, navImage.size.width, navImage.size.height);
    [navButton addTarget:self
                  action:@selector(revealMenu:)
        forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *navItem = [[UIBarButtonItem alloc] initWithCustomView:navButton];
    self.navigationItem.leftBarButtonItem = navItem;
}

- (void)revealMenu:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
}

@end
