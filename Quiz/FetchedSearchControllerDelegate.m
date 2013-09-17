//
//  FetchedSearchControllerDelegate.m
//  Quiz
//
//  Created by Alexander Ignatenko on 9/17/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "FetchedSearchControllerDelegate.h"

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation FetchedSearchControllerDelegate
{
    NSPredicate *_originalPredicate;
}

- (instancetype)initWithFetchedResultsController:(NSFetchedResultsController *)controller
{
    self = [super init];
    if (nil == self)
        return nil;

    _fetchedResultsController = controller;

    return self;
}

- (BOOL)searchController:(SearchController *)searchController
       shouldReloadTable:(UITableView *)tableView
      forFilterPredicate:(NSPredicate *)predicate;
{
    _fetchedResultsController.fetchRequest.predicate = predicate;
    NSError *error;
    if (![_fetchedResultsController performFetch:&error])
        DDLogError(@"Error: %@ %@ %@", THIS_FILE, THIS_METHOD, error);
    return YES;
}

- (void)searchControllerWillBeginSearch:(SearchController *)searchController
{
    _originalPredicate = _fetchedResultsController.fetchRequest.predicate;
}

- (void)searchControllerDidEndSearch:(SearchController *)searchController
{
    _fetchedResultsController.fetchRequest.predicate = _originalPredicate;
    NSError *error;
    if (![_fetchedResultsController performFetch:&error])
        DDLogError(@"Error: %@ %@ %@", THIS_FILE, THIS_METHOD, error);
}

@end
