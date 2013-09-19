//
//  QuestionDetailViewController.m
//  Quiz
//
//  Created by Alexander Ignatenko on 9/7/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "QuestionDetailViewController.h"
#import "QuestionDetailViewModel.h"

@interface QuestionDetailViewController ()

@property (strong, nonatomic) QuestionDetailViewModel *viewModel;

@end

@implementation QuestionDetailViewController

- (id)initWithQuestionRemoteID:(NSNumber *)questionRemoteID
{
    self = [self init];
    if (self) {
        _questionRemoteID = questionRemoteID;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.viewModel = [[QuestionDetailViewModel alloc]
                      initWithQuestionRemoteID:self.questionRemoteID context:self.localContext];
    self.viewModel.tableView = self.tableView;
}

- (void)discardUnsavedChanges
{
    [self.localContext refreshObject:self.viewModel.question mergeChanges:NO];
}

- (void)updateUI
{
}

- (void)updateModel
{
}

@end
