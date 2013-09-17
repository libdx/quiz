//
//  NavigationItemConfigurator.m
//  Quiz
//
//  Created by Alexander Ignatenko on 9/16/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "ItemsConfigurator.h"

@interface ItemsConfigurator ()
@property (strong, nonatomic) NSMutableArray *toolbarItems;
@end

@implementation ItemsConfigurator

- (instancetype)initWithViewController:(UIViewController *)viewController
{
    self = [super init];
    if (nil == self)
        return nil;

    _viewController = viewController;
    _toolbarItems = [NSMutableArray array];

    return self;
}

- (void)addSystemItem:(UIBarButtonSystemItem)systemItem withAction:(SEL)action
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:systemItem
                                                                          target:_viewController
                                                                          action:action];
    [self.toolbarItems addObject:item];
}

- (void)apply
{
    _viewController.toolbarItems = self.toolbarItems.copy;
}

@end
