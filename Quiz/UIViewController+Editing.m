//
//  UIViewController+Editing.m
//  Quiz
//
//  Created by Alexander Ignatenko on 9/8/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "UIViewController+Editing.h"
#import "UIViewController+Indie.h"

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation UIViewController (Editing)

@dynamic localContext;

- (NSManagedObjectContext *)newLocalContext
{
    return [NSManagedObjectContext MR_contextWithParent:[NSManagedObjectContext MR_contextForCurrentThread]];
}

- (NSManagedObjectContext *)setupLocalContextWithInstanceVariable:(NSManagedObjectContext *)ivar;
{
    if (nil == ivar) {
        ivar = [self newLocalContext];
    }
    return ivar;
}

- (void)setupDoneAndCancelButtons
{
    [self setupDoneButtonWithActionBlock:^(id sender) {
        if (self.isShowingModal)
            [self saveAndDismiss:sender];
        else
            [self save:sender];
    }];

    [self setupCancelButtonWithActionBlock:^(id sender) {
        if (self.isShowingModal)
            [self cancelAndDismiss:sender];
        else
            [self cancel:sender];
    }];
}

- (void)setupDoneButtonWithActionBlock:(void (^)(id sender))block
{
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone handler:^(id sender) {
        if (nil != block)
            block(sender);
    }];
}

- (void)setupCancelButtonWithActionBlock:(void (^)(id sender))block
{
    self.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel handler:^(id sender) {
        if (nil != block)
            block(sender);
    }];
}

- (void)save:(id)sender
{
    [self updateModel];
    [self.localContext MR_saveOnlySelfWithCompletion:^(BOOL success, NSError *error) {
        if (!success)
            DDLogError(@"Error: %@ %@ %@", THIS_FILE, THIS_METHOD, error);
    }];
}

- (void)saveAndDismiss:(id)sender
{
    [self save:sender];
    [self dismissViewController:YES];
}

- (void)cancel:(id)sender
{
    [self discardUnsavedChanges];
    [self updateUI];
}

- (void)cancelAndDismiss:(id)sender;
{
    [self cancel:sender];
    [self dismissViewController:YES];
}

- (void)discardUnsavedChanges
{
}

- (void)updateUI
{
}

- (void)updateModel
{
}

@end
