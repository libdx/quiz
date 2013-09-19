//
//  FetchedSearchControllerDelegate.h
//  Quiz
//
//  Created by Alexander Ignatenko on 9/17/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseSearchController.h"


@interface FetchedSearchControllerDelegate : NSObject <SearchControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

- (instancetype)initWithFetchedResultsController:(NSFetchedResultsController *)controller;

@end
