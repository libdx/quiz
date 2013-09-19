//
//  Configuration.m
//  Quiz
//
//  Created by Alexander Ignatenko on 9/19/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "Configuration.h"

@interface BaseConfiguration : NSObject <Configuration>
@property (weak, nonatomic) UIViewController *viewController;
@end

@implementation BaseConfiguration

- (NSMutableArray *)addSystemItem:(UIBarButtonSystemItem)systemItem toItems:(NSMutableArray **)items
{
    return [self addSystemItem:systemItem withAction:nil toItems:items];
}

- (NSMutableArray *)addSystemItem:(UIBarButtonSystemItem)systemItem withAction:(SEL)action
                          toItems:(NSMutableArray **)items
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:systemItem
                                                                          target:_viewController
                                                                          action:action];
    [*items addObject:item];
    return *items;
}

- (void)applyCreatingToolbarWithAction:(SEL)action
{

}

- (void)applyDetailNavBar
{

}

- (void)applyEditingDetailNavBarWithDoneAction:(SEL)done cancelAction:(SEL)cancel
{

}

@end

@interface MainConfiguration : BaseConfiguration

@end

@implementation MainConfiguration

- (void)applyCreatingToolbarWithAction:(SEL)action
{
    NSMutableArray *items = [NSMutableArray array];
    [self addSystemItem:UIBarButtonSystemItemFlexibleSpace toItems:&items];
    [self addSystemItem:UIBarButtonSystemItemAdd withAction:action toItems:&items];
    [self addSystemItem:UIBarButtonSystemItemFlexibleSpace toItems:&items];
    self.viewController.toolbarItems = items.copy;
}

- (void)applyDetailNavBar
{
    self.viewController.navigationItem.rightBarButtonItem = self.viewController.editButtonItem;
    self.viewController.navigationItem.leftBarButtonItem = nil;
}

- (void)applyEditingDetailNavBarWithDoneAction:(SEL)done cancelAction:(SEL)cancel
{
    self.viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                                             initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                             target:self.viewController action:done];
    self.viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                                            initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                            target:self.viewController action:cancel];
}

@end

@implementation Configurations

+ (id<Configuration>)currentConfigurationForViewController:(UIViewController *)vc
{
    static id<Configuration> _Configuration;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _Configuration = [[MainConfiguration alloc] init];
    });
    @synchronized(self) {
        _Configuration.viewController = vc;
    }
    return _Configuration;
}

@end

