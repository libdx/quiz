//
//  QuestionDetailViewController.m
//  Quiz
//
//  Created by Alexander Ignatenko on 9/7/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "QuestionDetailViewController.h"
#import "QuestionDetailTable.h"
#import "BasketsViewController.h"
#import "FieldsViewController.h"
#import "ControlsViewController.h"

@interface QuestionDetailViewController () <QuestionDetailTableDelegate>

@property (strong, nonatomic) QuestionDetailTable *table;
@property (strong, nonatomic) QZQuestion *question;

@end

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation QuestionDetailViewController

- (id)initWithQuestionID:(NSManagedObjectID *)questionID
{
    self = [super init];
    if (nil == self)
        return nil;

    _questionID = questionID;

    return self;
}

- (void)loadView
{
    self.view = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    [self.table reloadRowBoundData];
    [self.tableView reloadData];
}

- (void)updateModel
{
    [self.table updateRowObjects];
}

- (QZQuestion *)question
{
    if (nil == _question) {
        NSPredicate *byObjectID = [NSPredicate predicateWithFormat:@"SELF = %@", _questionID];
        _question = [QZQuestion MR_findFirstWithPredicate:byObjectID inContext:self.localContext];
        if (nil == _question) {
            _question = [QZQuestion createInContext:self.localContext];
        }
    }
    return _question;
}

#pragma mark - QuestionDetailTableDelegate

- (void)questionDetailTableDidSelectBasketItem:(QuestionDetailTable *)table
{
    [self.navigationController pushViewController:[[BasketsViewController alloc] initWithQuestion:self.question] animated:YES];
}

- (void)questionDetailTableDidSelectFieldItem:(QuestionDetailTable *)table
{
    [self.navigationController pushViewController:[[FieldsViewController alloc] initWithQuestion:self.question] animated:YES];
}

- (void)questionDetailTableDidSelectControlItem:(QuestionDetailTable *)table
{
    [self.navigationController pushViewController:[[ControlsViewController alloc] initWithQuestion:self.question] animated:YES];
}

@end
