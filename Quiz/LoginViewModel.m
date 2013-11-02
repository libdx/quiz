//
//  LoginViewModel.m
//  Quiz
//
//  Created by Alexander Ignatenko on 10/18/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "LoginViewModel.h"
#import "EntryCell.h"

@implementation LoginViewModel

- (instancetype)init
{
    self = [super init];
    if (nil == self)
        return nil;

    [self buildTableViewModel];

    return self;
}

- (void)buildTableViewModel
{
    NSMutableDictionary *userDict = @{@"username" : @"", @"password" : @""}.mutableCopy;

    // User section
    DXTableViewSection *userSection = [[DXTableViewSection alloc] initWithName:@"User"];

    // Username row
    DXTableViewRow *usernameRow = [[DXTableViewRow alloc] initWithCellReuseIdentifier:@"UsernameCell"];
    usernameRow.cellClass = [EntryCell class];
    [usernameRow bindObject:userDict withKeyPath:@"username"];

    usernameRow.configureCellBlock = ^(DXTableViewRow *row, EntryCell *cell) {
        cell.titleLabel.text = NSLocalizedString(@"Username", @"Username prompt on login");
        cell.textField.placeholder = NSLocalizedString(@"Username or Email", @"Placeholder for username input on login");
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

    // Building sign in section
    [signInSection addRow:signInRow];

    // Sign up section
    DXTableViewSection *signUpSection = [[DXTableViewSection alloc] initWithName:@"SignUp"];

    // Sign up row
    DXTableViewRow *signUpRow = [[DXTableViewRow alloc] initWithCellReuseIdentifier:@"SignUpCell"];
    signUpRow.cellClass = [UITableViewCell class];
    signUpRow.cellText = NSLocalizedString(@"Sign Un", @"Button title on login");

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

- (void)signIn
{
    [self updateRowObjects];
    [[UIApplication sharedApplication] sendAction:self.signInAction to:self.signInTarget from:self forEvent:nil];
}

- (void)signUp
{
    [self updateRowObjects];
    [[UIApplication sharedApplication] sendAction:self.signUpAction to:self.signUpTarget from:self forEvent:nil];
}
@end
