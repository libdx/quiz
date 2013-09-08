//
//  BaseTableViewController.m
//  Quiz
//
//  Created by Alexander Ignatenko on 9/8/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "BaseTableViewController.h"
#import "UIViewController+Editing.h"
#import "UIViewController+CoreData.h"

@interface BaseTableViewController ()

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultController;

@property (strong, nonatomic) NSManagedObjectContext *localContext;

@property (nonatomic, getter=isShowingModal) BOOL showingModal;

@property (copy, nonatomic) void (^willDismissViewController)(UIViewController *viewController);
@property (copy, nonatomic) void (^didDismissViewController)(UIViewController *viewController);

@end

@implementation BaseTableViewController

@synthesize fetchedResultController = _fetchedResultController;

@synthesize showingModal = _showingModal;
@synthesize willDismissViewController = _willDismissViewController;
@synthesize didDismissViewController = _didDismissViewController;

@synthesize localContext = _localContext;
- (NSManagedObjectContext *)localContext
{
    _localContext = [self setupLocalContextWithInstanceVariable:_localContext];
    return _localContext;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.fetchedResultController.sections[section] numberOfObjects];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.fetchedResultController.sections.count;
}

@end
