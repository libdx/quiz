//
//  QuestionDetailsViewController.m
//  Quiz
//
//  Created by Alexander Ignatenko on 9/7/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "QuestionDetailsViewController.h"
#import "NavigationItemConfigurator.h"

@interface QuestionDetailsViewController ()

@property (strong, nonatomic) QZQuestion *question;

@end

@implementation QuestionDetailsViewController

- (id)initWithQuestionRemoteID:(NSNumber *)questionRemoteID
{
    self = [self init];
    if (self) {
        _questionRemoteID = questionRemoteID;
    }
    return self;
}

- (QZQuestion *)question
{
    if (nil == _question) {
        _question = [QZQuestion MR_findFirstByAttribute:@"remoteID"
                                              withValue:_questionRemoteID
                                              inContext:self.localContext];
        if (nil == _question)
            _question = [QZQuestion MR_createInContext:self.localContext];
    }
    return _question;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[[NavigationItemConfigurator alloc] initWithViewController:self] applyEditStyle];
    [self updateUI];
}

- (void)discardUnsavedChanges
{
    [self.localContext refreshObject:self.question mergeChanges:NO];
}

- (void)updateUI
{
}

- (void)updateModel
{
}

@end
