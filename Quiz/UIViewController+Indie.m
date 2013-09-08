//
//  UIViewController+Indie.m
//  Quiz
//
//  Created by Alexander Ignatenko on 9/8/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "UIViewController+Indie.h"

@implementation UIViewController (Indie)

@dynamic showingModal;

@dynamic willDismissViewController;
@dynamic didDismissViewController;

- (void)dismissViewController:(BOOL)animated
{
    void (^willDismiss)() = ^{
        if (self.willDismissViewController)
            self.willDismissViewController(self);
    };

    void (^didDismiss)() = ^{
        if (self.didDismissViewController)
            self.didDismissViewController(self);
        // break reatin cycle
        self.willDismissViewController = nil;
        self.didDismissViewController = nil;
    };

    if (self.isShowingModal) {
        willDismiss();
        [self dismissViewControllerAnimated:animated completion:^{
            didDismiss();
        }];
    } else {
        if (self == self.navigationController.topViewController) {
            willDismiss();
            [self.navigationController popViewControllerAnimated:animated];
            didDismiss();
        }
    }
}

@end
