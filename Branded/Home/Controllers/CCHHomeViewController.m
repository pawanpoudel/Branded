//
//  CCHHomeViewController.m
//  Branded
//
//  Created by PAWAN POUDEL on 4/14/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

#import "CCHHomeViewController.h"
#import "ECSlidingViewController.h"
#import "CCHAppDelegate.h"

@implementation CCHHomeViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureNavigationBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self presentRegistrationView];
}

- (void)presentRegistrationView {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL loggedIn = [defaults boolForKey:@"kLoggedIn"];
    
    if (loggedIn == NO) {
        [self presentViewController:[CCHAppDelegate sharedAppDelegate].loginNavController
                           animated:NO
                         completion:nil];        
    }
}

- (void)configureNavigationBar {
    [self addMenuButton];
    self.title = @"Home";
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
