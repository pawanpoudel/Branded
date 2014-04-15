//
//  CCHLogInViewController.m
//  Branded
//
//  Created by PAWAN POUDEL on 4/15/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

#import "CCHLogInViewController.h"
#import "CCHLoginManager.h"
#import <objc/runtime.h>

static const NSInteger kDataEntrySection = 0;
static const NSInteger kEmailRowIndex = 0;
static const NSInteger kPasswordRowIndex = 1;
static char *const kAssociatedCell = "kAssociatedCell";

@interface CCHLogInViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableDictionary *userData;
@property (nonatomic) CCHLoginManager *loginManager;

@end

@implementation CCHLogInViewController

#pragma mark - Accessors

- (NSMutableDictionary *)userData {
    if (_userData == nil) {
        _userData = [@{} mutableCopy];
    }
    return _userData;
}

- (CCHLoginManager *)loginManager {
    if (_loginManager == nil) {
        _loginManager = [[CCHLoginManager alloc] init];
    }
    return _loginManager;
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Log In";
    [self addRightNavBarButton];
    [self addCancelButton];
}

- (void)addRightNavBarButton {
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Log In"
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:@selector(login:)];
    button.tintColor = [CCHColor appColor];
    self.navigationItem.rightBarButtonItem = button;
}

- (void)login:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"kLoggedIn"];
    [defaults synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addCancelButton {
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(dismissView:)];
    cancelButton.tintColor = [CCHColor appColor];
    self.navigationItem.leftBarButtonItem = cancelButton;
}

- (void)dismissView:(id)sender {
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self makeEmailTextFieldFirstResponder];
}

- (void)makeEmailTextFieldFirstResponder {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:kEmailRowIndex
                                                inSection:kDataEntrySection];
    
    UITableViewCell *emailCell = [self.tableView cellForRowAtIndexPath:indexPath];
    UITextField *emailTextField = nil;
    
    for (UIView *view in emailCell.contentView.subviews) {
        if ([view isMemberOfClass:[UITextField class]]) {
            emailTextField = (UITextField *)view;
        }
    }
    
    [emailTextField becomeFirstResponder];
}

#pragma mark - Table view methods

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    NSParameterAssert(section < 1);
    return [self numberOfDataEntryRows];
}

- (NSInteger)numberOfDataEntryRows {
    return 2;
}

- (NSString *)cellIdentifierForIndexPath:(NSIndexPath *)indexPath {
    static NSString *dataEntryCell = @"DataEntryCell";
    return dataEntryCell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [self cellIdentifierForIndexPath:indexPath];
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:identifier];
    }
    
    [self configureCell:cell
            atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell
          atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == kDataEntrySection) {
        [self configureDataEntryCell:cell
                         atIndexPath:indexPath];
    }
}

- (void)configureDataEntryCell:(UITableViewCell *)cell
                   atIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *rowInfo = [self infoForDataEntryRow:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:rowInfo[@"icon"]];
    
    UITextField *textField = [self textFieldWithInfo:rowInfo];
    objc_setAssociatedObject(textField, kAssociatedCell, cell, OBJC_ASSOCIATION_ASSIGN);
    [cell.contentView addSubview:textField];
    
    UIButton *button = rowInfo[@"accessoryButton"];
    if (button) {
        [cell.contentView addSubview:button];
    }
}

- (UITextField *)textFieldWithInfo:(NSDictionary *)info {
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(50, 3, 250, 35)];
    textField.delegate = self;
    [textField addTarget:self
                  action:@selector(textFieldDone:)
        forControlEvents:UIControlEventEditingDidEndOnExit];
    
    [textField addTarget:self
                  action:@selector(textFieldEditingChanged:)
        forControlEvents:UIControlEventEditingChanged];
    
    textField.returnKeyType = UIReturnKeyNext;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.placeholder = info[@"placeholder"];
    
    if (info[@"autocapitalizationType"]) {
        textField.autocapitalizationType = [info[@"autocapitalizationType"] integerValue];
    }
    else {
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    }
    
    if (info[@"keyboardType"]) {
        textField.keyboardType = [info[@"keyboardType"] integerValue];
    }
    
    if (info[@"secure"]) {
        textField.secureTextEntry = [info[@"secure"] intValue];
    }
    
    return textField;
}

- (NSDictionary *)infoForDataEntryRow:(NSInteger)row {
    NSMutableDictionary *info = [@{} mutableCopy];
    
    switch (row) {
        case kEmailRowIndex:
            info[@"icon"] = @"iconEmail";
            info[@"placeholder"] = @"john.appleseed@example.com";
            info[@"keyboardType"] = @(UIKeyboardTypeEmailAddress);
            break;
            
        case kPasswordRowIndex:
            info[@"icon"] = @"iconPassword";
            info[@"placeholder"] = @"6 characters or more";
            info[@"secure"] = @(YES);
            break;
    }
    
    return [info copy];
}

#pragma mark - UITextField methods

- (void)textFieldDone:(UITextField *)textField {
    UITableViewCell *cell = objc_getAssociatedObject(textField, kAssociatedCell);
    NSIndexPath *currentIndexPath = [self.tableView indexPathForCell:cell];
    NSUInteger row = [currentIndexPath row];
    row++;
    
    if (row >= [self numberOfDataEntryRows]) {
        row = 0;
    }
    
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:row
                                                   inSection:kDataEntrySection];
    UITableViewCell *nextCell = [self.tableView cellForRowAtIndexPath:newIndexPath];
    UITextField *nextTextField = nil;
    
    for (UIView *view in nextCell.contentView.subviews) {
        if ([view isMemberOfClass:[UITextField class]]) {
            nextTextField = (UITextField *)view;
        }
    }
    
    [nextTextField becomeFirstResponder];
}

- (void)textFieldEditingChanged:(UITextField *)textField {
    NSIndexPath *indexPath = [self indexPathForTextField:textField];
    
    [self collectText:textField
     fromDataEntryRow:indexPath.row];
}

- (NSIndexPath *)indexPathForTextField:(UITextField *)textField {
    UITableViewCell *cell = objc_getAssociatedObject(textField, kAssociatedCell);
    return [self.tableView indexPathForCell:cell];
}

- (void)collectText:(UITextField *)textField
   fromDataEntryRow:(NSInteger)row
{
    switch (row) {
        case kEmailRowIndex:
            self.userData[@"email"] = textField.text;
            break;
            
        case kPasswordRowIndex:
            self.userData[@"password"] = textField.text;
            break;
    }
}

@end
