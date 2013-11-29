//
//  LoginViewModel.m
//  Quiz
//
//  Created by Alexander Ignatenko on 10/18/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "LoginTable.h"
#import "EntryCell.h"

@interface LoginHeaderView : UIView
@property (strong, nonatomic) UILabel *label;
@end

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation LoginHeaderView

- (UILabel *)label
{
    if (nil == _label) {
        _label = [[UILabel alloc] init];
        _label.backgroundColor = [UIColor clearColor];
        _label.font = [UIFont fontWithName:@"Zapfino" size:40.0f];
    }
    return _label;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (NO == [self.subviews containsObject:_label])
        [self addSubview:self.label];
    [self.label sizeToFit];
    self.label.center = CGPointMake(floorf(CGRectGetWidth(self.frame) * 0.5),
                                    floorf(CGRectGetHeight(self.frame) * 0.5));
}

@end

@implementation LoginTable

- (instancetype)initWithTableView:(UITableView *)tableView
{
    self = [super initWithTableView:tableView];
    if (nil == self)
        return nil;

    [self buildTableViewModel];

    return self;
}

- (void)buildTableViewModel
{
    NSMutableDictionary *userDict = @{@"username" : @"", @"password" : @""}.mutableCopy;

    LoginHeaderView *header = [[LoginHeaderView alloc] initWithFrame:CGRectMake(0, 0, 10, 150)];
    header.label.text = NSLocalizedString(@"Quiz", "Application name as logo on login screen");
    header.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = header;

    // User section
    DXTableViewSection *userSection = [[DXTableViewSection alloc] initWithName:@"User"];

    // Username row
    DXTableViewRow *usernameRow = [[DXTableViewRow alloc] initWithCellReuseIdentifier:@"UsernameCell"];
    usernameRow.cellClass = [EntryCell class];
    [usernameRow bindObject:userDict withKeyPath:@"username"];

    usernameRow.configureCellBlock = ^(DXTableViewRow *row, EntryCell *cell) {
        cell.titleLabel.text = NSLocalizedString(@"Username", @"Username prompt on login");
        cell.textField.placeholder = NSLocalizedString(@"Username or Email", @"Placeholder for username input on login");
        [cell.textField configureUsernameField];
        [row becomeTargetOfTextFieldForEditingChanged:cell.textField withBlock:^(UITextField *textField) {
            row[@"username"] = textField.text;
        }];
    };

    // Password row
    DXTableViewRow *passwordRow = [[DXTableViewRow alloc] initWithCellReuseIdentifier:@"PasswordCell"];
    passwordRow.cellClass = [EntryCell class];
    [passwordRow bindObject:userDict withKeyPath:@"password"];

    passwordRow.configureCellBlock = ^(DXTableViewRow *row, EntryCell *cell) {
        NSString *password = NSLocalizedString(@"Password", @"Password prompt on login");
        cell.titleLabel.text = password;
        cell.textField.placeholder = password;
        [cell.textField configureSecureField];
        [row becomeTargetOfTextFieldForEditingChanged:cell.textField withBlock:^(UITextField *textField) {
            row[@"password"] = textField.text;
        }];
    };

    // Building user section
    [userSection addRows:@[usernameRow, passwordRow]];

    // Sign in section
    DXTableViewSection *signInSection = [[DXTableViewSection alloc] initWithName:@"SignIn"];

    // Sign in row
    DXTableViewRow *signInRow = [[DXTableViewRow alloc] initWithCellReuseIdentifier:@"SignInCell"];
    signInRow.cellClass = [UITableViewCell class];
    signInRow.cellText = NSLocalizedString(@"Sign In", @"Button title on login");
    [signInRow setDidSelectRowBlock:^(DXTableViewRow *row) {
        [self signIn];
    }];

    // Building sign in section
    [signInSection addRow:signInRow];

    // Sign up section
    DXTableViewSection *signUpSection = [[DXTableViewSection alloc] initWithName:@"SignUp"];

    // Sign up row
    DXTableViewRow *signUpRow = [[DXTableViewRow alloc] initWithCellReuseIdentifier:@"SignUpCell"];
    signUpRow.cellClass = [UITableViewCell class];
    signUpRow.cellText = NSLocalizedString(@"Sign Un", @"Button title on login");
    [signUpRow setDidSelectRowBlock:^(DXTableViewRow *row) {
        [self signUp];
    }];

    // Building sign up section
    [signUpSection addRow:signUpRow];

    // Building table view model
    [self addSections:@[userSection, signInSection, signUpSection]];

    // Section-wide row options
    for (DXTableViewSection *section in self.sections) {
        for (DXTableViewRow *row in section.rows) {
            row.editingStyle = UITableViewCellEditingStyleNone;
            row.shouldIndentWhileEditingRow = NO;
        }
    }
}

- (NSString *)username
{
    return [[[self sectionWithName:@"User"] rowWithIdentifier:@"UsernameCell"].boundObject valueForKey:@"username"];
}

- (NSString *)password
{
    return [[[self sectionWithName:@"User"] rowWithIdentifier:@"PasswordCell"].boundObject valueForKey:@"password"];
}

- (BOOL)validateInputs
{
    BOOL res = YES;
    res = [self username] && [self password];
    if (NO == res)
        LogError(@"Username or password are invalid");
    return res;
}

- (void)signIn
{
    if (NO == [self validateInputs])
        return;

    [self updateRowObjects];
    [[UIApplication sharedApplication] sendAction:self.signInAction to:self.signInTarget from:self forEvent:nil];
}

- (void)signUp
{
    if (NO == [self validateInputs])
        return;

    [self updateRowObjects];
    [[UIApplication sharedApplication] sendAction:self.signUpAction to:self.signUpTarget from:self forEvent:nil];
}
@end
