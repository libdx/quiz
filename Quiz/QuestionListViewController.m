//
//  QuestionListViewController.m
//  Quiz
//
//  Created by Alexander Ignatenko on 9/7/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "QuestionListViewController.h"
#import "UIViewController+CoreData.h"
#import "QuestionDetailsViewController.h"
#import "BaseNavigationController.h"

@interface QuestionListViewController ()

@end

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation QuestionListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.toolbarHidden = NO;
    self.toolbarItems =
    @[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addQuestion:)],
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil]
    ];
    self.fetchedResultController = [QZQuestion MR_fetchAllSortedBy:@"title"
                                                         ascending:YES
                                                     withPredicate:nil
                                                           groupBy:@"level"
                                                          delegate:self];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"QuestionCell"];
}

- (NSString *)nibName
{
    return @"QuestionListViewController";
}

#pragma mark - UITableViewDataSource and UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuestionCell" forIndexPath:indexPath];
    cell.textLabel.text = [[self.fetchedResultController objectAtIndexPath:indexPath] title];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    QZQuestion *question = [self.fetchedResultController objectAtIndexPath:indexPath];
    QuestionDetailsViewController *detailsController = [[QuestionDetailsViewController alloc]
                                                        initWithQuestionRemoteID:question.remoteID];
    [self.navigationController pushViewController:detailsController animated:YES];
}

- (void)addQuestion:(id)sender
{
    QuestionDetailsViewController *detailsController = [[QuestionDetailsViewController alloc] init];
    BaseNavigationController *navController = [[BaseNavigationController alloc]
                                               initWithRootViewController:detailsController];
    [self.navigationController presentViewController:navController animated:YES completion:nil];
}

@end
