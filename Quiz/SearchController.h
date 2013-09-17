//
//  SearchController.h
//  Quiz
//
//  Created by Alexander Ignatenko on 9/17/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SearchController;

@protocol SearchControllerDelegate <NSObject>

- (BOOL)searchController:(SearchController *)searchController
       shouldReloadTable:(UITableView *)tableView
      forFilterPredicate:(NSPredicate *)predicate;

- (void)searchControllerWillBeginSearch:(SearchController *)searchController;
- (void)searchControllerDidEndSearch:(SearchController *)searchController;

@end

@interface SearchController : NSObject <UISearchDisplayDelegate>

@property (weak, nonatomic) id<SearchControllerDelegate> delegate;

- (instancetype)initWithDelegate:(id<SearchControllerDelegate>)delegate;

- (void)addCellClass:(Class)cellClass withCellReuseIdentifier:(NSString *)identifier;

- (void)addCellNib:(Class)cellNib withCellReuseIdentifier:(NSString *)identifier;

/**
 Override in subclasses
 */
- (NSPredicate *)createFilterPredicateWithSearchString:(NSString *)string scope:(NSInteger)scope;

@end
