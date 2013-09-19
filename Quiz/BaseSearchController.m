//
//  BaseSearchController.m
//  Quiz
//
//  Created by Alexander Ignatenko on 9/17/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "BaseSearchController.h"

@implementation BaseSearchController
{
    NSString *_searchString;
    NSInteger _scopeOption;
    NSMutableDictionary *_cellClasses;
    NSMutableDictionary *_cellNibs;
}

- (instancetype)initWithDelegate:(id<SearchControllerDelegate>)delegate;
{
    self = [super init];
    if (nil == self)
        return nil;

    _delegate = delegate;

    return self;
}

- (NSPredicate *)createFilterPredicateWithSearchString:(NSString *)string scope:(NSInteger)scope
{
    return nil;
}

- (void)registerCellsClassesAndNibsForTableView:(UITableView *)tableView
{
    for (NSString *identifier in _cellClasses)
        [tableView registerClass:_cellClasses[identifier] forCellReuseIdentifier:identifier];
    for (NSString *identifier in _cellNibs)
        [tableView registerNib:_cellNibs[identifier] forCellReuseIdentifier:identifier];
}

- (void)addCellClass:(Class)cellClass withCellReuseIdentifier:(NSString *)identifier
{
    if (nil == _cellClasses)
        _cellClasses = [NSMutableDictionary dictionary];
    [_cellClasses setObject:cellClass forKey:identifier];
}

- (void)addCellNib:(Class)cellNib withCellReuseIdentifier:(NSString *)identifier
{
    if (nil == _cellNibs)
        _cellNibs = [NSMutableDictionary dictionary];
    [_cellNibs setObject:cellNib forKey:identifier];
}

#pragma mark - UISearchDisplayDelegate

- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
    [_delegate searchControllerWillBeginSearch:self];
}

- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
    [_delegate searchControllerDidEndSearch:self];
}

- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView
{
    [self registerCellsClassesAndNibsForTableView:tableView];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    _searchString = searchString;
    return [_delegate searchController:self
                     shouldReloadTable:controller.searchResultsTableView
                    forFilterPredicate:[self createFilterPredicateWithSearchString:_searchString scope:_scopeOption]];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    _scopeOption = searchOption;
    return [_delegate searchController:self
                     shouldReloadTable:controller.searchResultsTableView
                    forFilterPredicate:[self createFilterPredicateWithSearchString:_searchString scope:_scopeOption]];
}

- (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller
{
    [_delegate searchController:self
              shouldReloadTable:controller.searchResultsTableView
             forFilterPredicate:nil];
}

@end
