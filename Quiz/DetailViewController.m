//
//  DetailViewController.m
//  Quiz
//
//  Created by Alexander Ignatenko on 9/16/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation DetailViewController

- (void)save:(id)sender
{
    [self updateModel];
}

- (void)cancel:(id)sender
{
    [self discardUnsavedChanges];
    [self updateUI];
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
    [self updateModel];
    [self.localContext MR_saveOnlySelfWithCompletion:^(BOOL success, NSError *error) {
        if (!success)
            DDLogError(@"Error: %@ %@ %@", THIS_FILE, THIS_METHOD, error);
    }];
}

@end
