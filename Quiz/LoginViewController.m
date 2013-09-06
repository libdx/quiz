//
//  LoginViewController.m
//  Quiz
//
//  Created by Alexander Ignatenko on 9/5/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "LoginViewController.h"
#import "QZUser.h"

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

@interface LoginViewController ()
@property (strong, nonatomic) QEntryElement *usernameElement;
@end

@implementation LoginViewController

- (QRootElement *)buildRootWithElements
{
    QRootElement *rootElement = [[QRootElement alloc] init];
    rootElement.grouped = YES;
    rootElement.controllerName = NSStringFromClass([self class]);

    QSection *inputsSection = [[QSection alloc] init];
    LoginHeaderView *inputsHeader = [[LoginHeaderView alloc] initWithFrame:CGRectMake(0, 0, 10, 150)];
    inputsHeader.label.text = @"Quiz";
    inputsHeader.backgroundColor = [UIColor clearColor];
    inputsSection.headerView = inputsHeader;
    self.usernameElement = [[QEntryElement alloc] initWithTitle:@"Username" Value:@"" Placeholder:@"Username or Email"];
    self.usernameElement.key = @"username";
    self.usernameElement.keyboardType = UIKeyboardTypeEmailAddress;
    QEntryElement *passwordElement = [[QEntryElement alloc] initWithTitle:@"Password" Value:@"" Placeholder:@"Password"];
    passwordElement.secureTextEntry = YES;
    [inputsSection addElement:self.usernameElement];
    [inputsSection addElement:passwordElement];

    QSection *signInSection = [[QSection alloc] init];
    QButtonElement *signInButton = [[QButtonElement alloc] initWithTitle:@"Sign In"];
    signInButton.controllerAction = @"signIn:";
    [signInSection addElement:signInButton];
    QSection *signUpSection = [[QSection alloc] init];
    QButtonElement *signUpButton = [[QButtonElement alloc] initWithTitle:@"Sign Up"];
    signUpButton.controllerAction = @"signUp:";
    [signUpSection addElement:signUpButton];

    [rootElement addSection:inputsSection];
    [rootElement addSection:signInSection];
    [rootElement addSection:signUpSection];

    return rootElement;
}

- (id)init
{
    return [super initWithRoot:[self buildRootWithElements]];
}

- (void)signIn:(id)sender
{
    NSMutableDictionary *userDict = @{@"username" : @"", @"password" : @""}.mutableCopy;
    [self.usernameElement fetchValueIntoObject:userDict];

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[QuizAuthClient defaultClient] authenticateUsername:userDict[@"username"] withPassword:userDict[@"password"] success:^{
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.appDelegate viewControllerDidSignInUser:self];
    } failure:^(NSError *error) {
        DDLogError(@"Error: %@ %@ %@", THIS_FILE, THIS_METHOD, error);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}

- (void)signUp:(id)sender
{
}

@end
