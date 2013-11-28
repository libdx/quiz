//
//  FetchedTableViewDataSource.h
//  Quiz
//
//  Created by Alexander Ignatenko on 9/16/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FetchedTableViewDataSource : NSObject <UITableViewDataSource, NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (copy, nonatomic) NSString *cellIdentifier;
@property (copy, nonatomic) void (^configureCellBlock)(UITableView *tableView, id cell, NSIndexPath *indexPath, id object);

@property (nonatomic) BOOL reloadRowOnUpdate; // Default is YES

- (instancetype)initWithTableView:(UITableView *)tableView
         fetchedResultsController:(NSFetchedResultsController *)fetchedResultsController
                   cellIdentifier:(NSString *)cellIdentifier
               configureCellBlock:(void (^)(UITableView *tableView, id cell, NSIndexPath *indexPath, id object))configureCellBlock;

@end
