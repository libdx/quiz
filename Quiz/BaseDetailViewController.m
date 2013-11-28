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

    return self;
}

- (void)updateNavBar
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                              target:self action:@selector(save:)];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                             target:self action:@selector(cancel:)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateNavBar];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)save:(id)sender
{
    [self updateModel];
    if (self.dismissViewControllerBlock)
        self.dismissViewControllerBlock(self, YES);
}

- (void)cancel:(id)sender
{
    [self discardUnsavedChanges];
    [self updateUI];
    if (self.dismissViewControllerBlock)
        self.dismissViewControllerBlock(self, NO);
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
//        _localContext = [NSManagedObjectContext MR_contextWithParent:[NSManagedObjectContext MR_contextForCurrentThread]];
        _localContext = [NSManagedObjectContext MR_newMainQueueContext];
        _localContext.parentContext = [NSManagedObjectContext MR_contextForCurrentThread];
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
