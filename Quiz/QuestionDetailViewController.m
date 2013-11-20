//
//  QuestionDetailViewController.m
//  Quiz
//
//  Created by Alexander Ignatenko on 9/7/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "QuestionDetailViewController.h"
#import "QuestionDetailTable.h"

@interface QuestionDetailViewController () <QuestionDetailTableDelegate>

@property (strong, nonatomic) QuestionDetailTable *table;
@property (strong, nonatomic) QZQuestion *question;

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
    self.table = [[QuestionDetailTable alloc] initWithQuestion:self.question];
    self.table.delegate = self;
    self.table.tableView = self.tableView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden = YES;
}

- (void)discardUnsavedChanges
{
    [self.localContext refreshObject:self.question mergeChanges:NO];
}

- (void)updateUI
{
    [self.tableView reloadData];
}

- (void)updateModel
{
    [self.table updateRowObjects];
}

- (QZQuestion *)question
{
    if (nil == _question) {
        _question = [QZQuestion MR_findFirstByAttribute:@"remoteID"
                                              withValue:_questionRemoteID
                                              inContext:self.localContext];
        if (nil == _question) {
            _question = [QZQuestion MR_createInContext:self.localContext];
        }
    }
    return _question;
}

#pragma mark - QuestionDetailViewModelDelegate

- (void)questionDetailTableDidSelectBasketItem:(QuestionDetailTable *)table
{
    
}

@end
