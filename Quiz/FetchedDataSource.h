//
//  FetchedDataSource.h
//  Quiz
//
//  Created by Alexander Ignatenko on 9/16/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FetchedDataSource : NSObject <UITableViewDataSource, NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (copy, nonatomic) UITableViewCell *(^cellForRowAtIndexPathBlock)(NSIndexPath *);

- (instancetype)initWithTableView:(UITableView *)tableView
         fetchedResultsController:(NSFetchedResultsController *)fetchedResultsController
       cellForRowAtIndexPathBlock:(UITableViewCell *(^)(NSIndexPath *))cellForRowAtIndexPathBlock;

@end
