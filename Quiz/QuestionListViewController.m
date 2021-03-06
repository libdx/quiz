//
//  QuestionListViewController.m
//  Quiz
//
//  Created by Alexander Ignatenko on 9/7/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "QuestionListViewController.h"
#import "QuestionDetailViewController.h"
#import "FetchedTableViewDataSource.h"
#import "BaseTableViewDelegate.h"
#import "BaseSearchController.h"
#import "FetchedSearchControllerDelegate.h"

@interface QuestionListSearchController : BaseSearchController @end

@implementation QuestionListSearchController

- (NSPredicate *)createFilterPredicateWithSearchString:(NSString *)string scope:(NSInteger)scope
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title contains[cd] %@", string];
    return predicate;
}

@end

@interface QuestionListViewController ()

@property (strong, nonatomic) FetchedTableViewDataSource *dataSource;
@property (strong, nonatomic) BaseTableViewDelegate *delegate;
@property (strong, nonatomic) QuestionListSearchController *searchController;
@property (strong, nonatomic) FetchedSearchControllerDelegate *searchControllerDelegate;

@end

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation QuestionListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    weakify(self, weak_self);

    self.toolbarItems = [UIBarButtonItem creationBarItemsWithTarget:self action:@selector(addQuestion:)];

    NSFetchedResultsController *controller = [QZQuestion MR_fetchAllSortedBy:@"title"
                                                                   ascending:YES
                                                               withPredicate:nil
                                                                     groupBy:@"level"
                                                                    delegate:nil];

    void (^configureCellBlock)() = ^(UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath, QZQuestion *question) {
        cell.textLabel.text = question.title;
    };

    self.dataSource = [[FetchedTableViewDataSource alloc] initWithTableView:self.tableView
                                                   fetchedResultsController:controller
                                                             cellIdentifier:@"QuestionCell"
                                                         configureCellBlock:configureCellBlock];

    self.delegate = [[BaseTableViewDelegate alloc] initWithTableView:self.tableView
                                                   didSelectRowBlock:^(UITableView *tableView, NSIndexPath *indexPath)
    {
        strongify(self, weak_self);

        QZQuestion *question = [controller objectAtIndexPath:indexPath];

        QuestionDetailViewController *detailController = [[QuestionDetailViewController alloc]
                                                            initWithQuestionID:question.objectID];
        detailController.dismissViewControllerBlock = ^(UIViewController *vc, BOOL didSave) {
            [vc.navigationController popToRootViewControllerAnimated:YES];
        };

        [self.navigationController pushViewController:detailController animated:YES];
    }];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"QuestionCell"];

    self.searchControllerDelegate = [[FetchedSearchControllerDelegate alloc] initWithFetchedResultsController:controller];
    self.searchController = [[QuestionListSearchController alloc] initWithDelegate:self.searchControllerDelegate];
    [self.searchController addCellClass:[UITableViewCell class] withCellReuseIdentifier:@"QuestionCell"];

    self.searchDisplayController.delegate = self.searchController;
    self.searchDisplayController.searchResultsDataSource = self.dataSource;
    self.searchDisplayController.searchResultsDelegate = self.delegate;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden = NO;
}

- (NSString *)nibName
{
    return @"QuestionListViewController";
}

- (void)addQuestion:(id)sender
{
    QuestionDetailViewController *detailController = [[QuestionDetailViewController alloc] init];
    detailController.dismissViewControllerBlock = ^(UIViewController *vc, BOOL didSave) {
        [vc dismissViewControllerAnimated:YES completion:nil];
    };

    UINavigationController *navController = [[UINavigationController alloc]
                                               initWithRootViewController:detailController];
    [self.navigationController presentViewController:navController animated:YES completion:nil];
}

@end
