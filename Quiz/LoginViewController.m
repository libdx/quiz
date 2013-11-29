//
//  LoginViewController.m
//  Quiz
//
//  Created by Alexander Ignatenko on 9/5/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginTable.h"

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@interface LoginViewController ()
@end

@implementation LoginViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (nil == self)
        return nil;

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    LoginTable *table = [[LoginTable alloc] initWithTableView:self.tableView];
    table.signInTarget = self;
    table.signInAction = @selector(signIn:);
    table.signUpTarget = self;
    table.signUpAction = @selector(signUp:);
}

- (void)signIn:(id)sender
{
    NSMutableDictionary *userDict = @{@"username" : [sender username], @"password" : [sender password]}.mutableCopy;

    [SVProgressHUD show];
    [[QuizAuthClient defaultClient] authenticateUsername:userDict[@"username"] withPassword:userDict[@"password"] success:^{
        [SVProgressHUD dismiss];
        [self.appDelegate viewControllerDidSignInUser:self];
    } failure:^(NSError *error) {
        LogError(@"%@", error);
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Username or password is incorrect", @"Login error message")];
    }];
}

- (void)signUp:(id)sender
{
}

@end
