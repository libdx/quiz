//
//  QuestionDetailViewController.m
//  Quiz
//
//  Created by Alexander Ignatenko on 9/7/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "QuestionDetailViewController.h"
#import "QuestionDetailViewModel.h"

@interface QuestionDetailViewController () <QuestionDetailViewModelDelegate>

@property (strong, nonatomic) QuestionDetailViewModel *viewModel;

@end

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation QuestionDetailViewController

- (id)initWithQuestionRemoteID:(NSNumber *)questionRemoteID
{
    self = [super init];
    if (self) {
        _questionRemoteID = questionRemoteID;
    }
    return self;
}

- (void)loadView
{
    self.view = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.allowsSelectionDuringEditing = YES;
    self.viewModel = [[QuestionDetailViewModel alloc]
                      initWithQuestionRemoteID:self.questionRemoteID context:self.localContext];
    self.viewModel.delegate = self;
    self.viewModel.tableView = self.tableView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden = YES;
}

- (void)discardUnsavedChanges
{
    [self.localContext refreshObject:self.viewModel.question mergeChanges:NO];
}

- (void)updateUI
{
    [self.tableView reloadData];
}

- (void)updateModel
{
    [self.viewModel updateRowObjects];
}

#pragma mark - QuestionDetailViewModelDelegate

- (void)questionDetailViewModelDidSelectBasketItem:(QuestionDetailViewModel *)viewModel
{
    
}

@end
