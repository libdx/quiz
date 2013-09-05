//
//  LoginViewController.m
//  Quiz
//
//  Created by Alexander Ignatenko on 9/5/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginHeaderView : UIView
@property (strong, nonatomic) UILabel *label;
@end

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
    QEntryElement *loginElement = [[QEntryElement alloc] initWithTitle:@"Username" Value:@"" Placeholder:@"Username or Email"];
    loginElement.keyboardType = UIKeyboardTypeEmailAddress;
    QEntryElement *passwordElement = [[QEntryElement alloc] initWithTitle:@"Password" Value:@"" Placeholder:@"Password"];
    passwordElement.secureTextEntry = YES;
    [inputsSection addElement:loginElement];
    [inputsSection addElement:passwordElement];

    QSection *signInSection = [[QSection alloc] init];
    QButtonElement *signInButton = [[QButtonElement alloc] initWithTitle:@"Sign In"];
    signInButton.controllerAction = @"signIn:";
    [signInSection addElement:signInButton];
    QSection *registrationSection = [[QSection alloc] init];
    QButtonElement *registrationButton = [[QButtonElement alloc] initWithTitle:@"Registration"];
    registrationButton.controllerAction = @"registration:";
    [registrationSection addElement:registrationButton];

    [rootElement addSection:inputsSection];
    [rootElement addSection:signInSection];
    [rootElement addSection:registrationSection];

    return rootElement;
}

- (id)init
{
    return [super initWithRoot:[self buildRootWithElements]];
}

- (void)signIn:(id)sender
{
}

- (void)registration:(id)sender
{
}

@end
