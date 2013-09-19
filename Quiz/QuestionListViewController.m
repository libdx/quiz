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

@interface QuestionListTableViewDelegate : BaseTableViewDelegate

@property (copy, nonatomic) void (^didSelectRowBlock)(NSIndexPath *);

- (instancetype)initWithDidSelectRowBlock:(void (^)(NSIndexPath *indexPath))didSelectRowBlock;

@end

@implementation QuestionListTableViewDelegate

- (instancetype)initWithDidSelectRowBlock:(void (^)(NSIndexPath *indexPath))didSelectRowBlock
{
    self = [super init];
    if (nil == self)
        return nil;

    self.didSelectRowBlock = didSelectRowBlock;

    return self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (nil != self.didSelectRowBlock)
        self.didSelectRowBlock(indexPath);
}

@end

@interface QuestionListViewController ()

@property (strong, nonatomic) FetchedTableViewDataSource *dataSource;

@property (strong, nonatomic) QuestionListTableViewDelegate *delegate;

@end

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation QuestionListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.toolbarHidden = NO;
    [self.configuration applyCreatingToolbarWithAction:@selector(addQuestion:)];

    NSFetchedResultsController *controller = [QZQuestion MR_fetchAllSortedBy:@"title"
                                                                   ascending:YES
                                                               withPredicate:nil
                                                                     groupBy:@"level"
                                                                    delegate:nil];

    void (^configureCellBlock)() = ^(UITableViewCell *cell, QZQuestion *question) {
        cell.textLabel.text = question.title;
    };
    self.dataSource = [[FetchedTableViewDataSource alloc] initWithTableView:self.tableView
                                                   fetchedResultsController:controller
                                                             cellIdentifier:@"QuestionCell"
                                                         configureCellBlock:configureCellBlock];

    self.delegate = [[QuestionListTableViewDelegate alloc] initWithDidSelectRowBlock:^(NSIndexPath *indexPath) {
        QZQuestion *question = [controller objectAtIndexPath:indexPath];
        QuestionDetailViewController *detailController = [[QuestionDetailViewController alloc]
                                                            initWithQuestionRemoteID:question.remoteID];
        [self.navigationController pushViewController:detailController animated:YES];
        detailController.dismissViewControllerBlock = ^(UIViewController *vc, BOOL didSave) {
            [vc.navigationController popToRootViewControllerAnimated:YES];
        };
        detailController.editing = YES;
        detailController.shouldDismissOnSave = NO;
    }];
    self.tableView.delegate = self.delegate;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"QuestionCell"];
}

- (NSString *)nibName
{
    return @"QuestionListViewController";
}

- (void)addQuestion:(id)sender
{
    QuestionDetailViewController *detailController = [[QuestionDetailViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc]
                                               initWithRootViewController:detailController];
    [self.navigationController presentViewController:navController animated:YES completion:nil];
    detailController.dismissViewControllerBlock = ^(UIViewController *vc, BOOL didSave) {
        [vc dismissViewControllerAnimated:YES completion:nil];
    };
    detailController.editing = YES;
    detailController.shouldDismissOnCancel = YES;
    detailController.shouldDismissOnSave = YES;
}

@end
