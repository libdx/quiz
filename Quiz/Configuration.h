//
//  Configuration.h
//  Quiz
//
//  Created by Alexander Ignatenko on 9/19/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Configuration <NSObject>

@property (weak, nonatomic) UIViewController *viewController;

- (void)applyCreatingToolbarWithAction:(SEL)action;
- (void)applyDetailNavBar; // uses editButtonItem
- (void)applyEditingDetailNavBarWithDoneAction:(SEL)done cancelAction:(SEL)cancel;

@end

@interface Configurations : NSObject

+ (id<Configuration>)currentConfigurationForViewController:(UIViewController *)vc;

@end
