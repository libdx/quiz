//
//  NavigationItemConfigurator.h
//  Quiz
//
//  Created by Alexander Ignatenko on 9/17/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NavigationItemConfigurator : NSObject

@property (weak, nonatomic) UIViewController *viewController;

@property (nonatomic) SEL doneAction;
@property (nonatomic) SEL cancelAction;

- (instancetype)initWithViewController:(UIViewController *)viewController;

- (void)applyEditStyle;
- (void)applyReadStyle;

@end
