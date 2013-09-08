//
//  BaseNavigationController.m
//  Quiz
//
//  Created by Alexander Ignatenko on 9/8/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()
{
    BOOL _showingModal;
}

@end

@implementation BaseNavigationController

- (BOOL)showingModal
{
    return _showingModal;
}

- (void)setShowingModal:(BOOL)showingModal
{
    _showingModal = showingModal;
    @try {
        [self.viewControllers[0] setShowingModal:_showingModal];
    } @catch (NSException *exception) {
        // do nothing
    }
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion
{
    viewControllerToPresent.showingModal = YES;
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
}

@end
