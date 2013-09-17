//
//  NavigationItemConfigurator.h
//  Quiz
//
//  Created by Alexander Ignatenko on 9/16/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemsConfigurator : NSObject

@property (weak, nonatomic) UIViewController *viewController;

- (instancetype)initWithViewController:(UIViewController *)viewController;

- (void)addSystemItem:(UIBarButtonSystemItem)systemItem withAction:(SEL)action;

- (void)apply;

@end
