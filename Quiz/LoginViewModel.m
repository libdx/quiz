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
    DXTableViewSection *userSection = [[DXTableViewSection alloc] initWithName:@"User"];
    DXTableViewRow *usernameRow = [[DXTableViewRow alloc] initWithCellReuseIdentifier:@"UsernameCell"];
    usernameRow.cellClass = [EntryCell class];
    usernameRow.configureCellBlock = ^(DXTableViewRow *row, EntryCell *cell) {
        cell.titleLabel.text = NSLocalizedString(@"Username", @"Username prompt on login");
        cell.textField.placeholder = NSLocalizedString(@"Username or Email", @"Placeholder for username input on login");
    };
    DXTableViewRow *passwordRow = [[DXTableViewRow alloc] initWithCellReuseIdentifier:@"PasswordCell"];
    passwordRow.cellClass = [EntryCell class];
    passwordRow.configureCellBlock = ^(DXTableViewRow *row, EntryCell *cell) {
        NSString *password = NSLocalizedString(@"Password", @"Password prompt on login");
        cell.titleLabel.text = password;
        cell.textField.placeholder = password;
    };
    [userSection addRows:@[usernameRow, passwordRow]];

    DXTableViewSection *signInSection = [[DXTableViewSection alloc] initWithName:@"SignIn"];
    DXTableViewRow *signInRow = [[DXTableViewRow alloc] initWithCellReuseIdentifier:@"SignInCell"];
    signInRow.cellClass = [UITableViewCell class];
    signInRow.cellText = NSLocalizedString(@"Sign In", @"Button title on login");
    [signInSection addRow:signInRow];

    DXTableViewSection *signUpSection = [[DXTableViewSection alloc] initWithName:@"SignUp"];
    DXTableViewRow *signUpRow = [[DXTableViewRow alloc] initWithCellReuseIdentifier:@"SignUpCell"];
    signUpRow.cellClass = [UITableViewCell class];
    signUpRow.cellText = NSLocalizedString(@"Sign Un", @"Button title on login");
    [signUpSection addRow:signUpRow];

    [self addSections:@[userSection, signInSection, signUpSection]];
}

@end
