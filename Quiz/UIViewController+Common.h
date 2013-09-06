//
//  UIViewController+Common.h
//  Quiz
//
//  Created by Alexander Ignatenko on 9/6/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDelegate;

@interface UIViewController (Common)

@property (nonatomic, readonly) AppDelegate *appDelegate;

@end
