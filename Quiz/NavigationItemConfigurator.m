//
//  NavigationItemConfigurator.m
//  Quiz
//
//  Created by Alexander Ignatenko on 9/17/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "NavigationItemConfigurator.h"

@implementation NavigationItemConfigurator

- (instancetype)initWithViewController:(UIViewController *)viewController
{
    self = [super init];
    if (nil == self)
        return nil;

    _viewController = viewController;

    return self;
}

- (void)applyEditStyle
{
    _viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                                         initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                         target:_viewController action:self.doneAction];
    _viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                                        initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                        target:_viewController action:self.cancelAction];
}

- (void)applyReadStyle
{
    _viewController.navigationItem.rightBarButtonItem = _viewController.editButtonItem;
}

@end
