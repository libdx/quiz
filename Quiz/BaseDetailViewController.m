//
//  BaseDetailViewController.m
//  Quiz
//
//  Created by Alexander Ignatenko on 9/16/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "BaseDetailViewController.h"

@interface BaseDetailViewController ()

@end

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation BaseDetailViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (nil == self)
        return nil;

    _shouldDismissOnCancel = YES;
    _shouldDismissOnSave = YES;

    return self;
}

- (void)updateNavBar
{
    if (self.isEditing) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                                  initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                  target:self action:@selector(save:)];

        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                                 initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                 target:self action:@selector(cancel:)];
    } else {
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
        self.navigationItem.leftBarButtonItem = nil;
    }
}

- (void)viewDidLoad
{
    [self updateNavBar];
    [self updateUI];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self updateNavBar];
}

- (void)save:(id)sender
{
    [self updateModel];
    if (self.shouldDismissOnSave) {
        if (self.dismissViewControllerBlock)
            self.dismissViewControllerBlock(self, YES);
    } else {
        [self setEditing:NO animated:YES];
    }
}

- (void)cancel:(id)sender
{
    [self discardUnsavedChanges];
    [self updateUI];
    if (self.shouldDismissOnCancel) {
        if (self.dismissViewControllerBlock)
            self.dismissViewControllerBlock(self, NO);
    } else {
        [self setEditing:NO animated:YES];
    }
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

@implementation ManagedDetailViewController

- (NSManagedObjectContext *)localContext
{
    if (nil == _localContext) {
        _localContext = [NSManagedObjectContext MR_contextWithParent:[NSManagedObjectContext MR_contextForCurrentThread]];
    }
    return _localContext;
}

- (void)save:(id)sender
{
    [super save:sender];
    [self.localContext MR_saveOnlySelfWithCompletion:^(BOOL success, NSError *error) {
        if (!success)
            DDLogError(@"Error: %@ %@ %@", THIS_FILE, THIS_METHOD, error);
    }];
}

@end
