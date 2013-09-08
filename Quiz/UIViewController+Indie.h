//
//  UIViewController+Indie.h
//  Quiz
//
//  Created by Alexander Ignatenko on 9/8/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Indie)

@property (nonatomic, getter=isShowingModal) BOOL showingModal;

@property (copy, nonatomic) void (^willDismissViewController)(UIViewController *viewController);
@property (copy, nonatomic) void (^didDismissViewController)(UIViewController *viewController);

- (void)dismissViewController:(BOOL)animated;

@end
