//
//  QuestionDetailViewModel.m
//  Quiz
//
//  Created by Alexander Ignatenko on 9/19/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "QuestionDetailViewModel.h"
#import "EntryCell.h"
#import "EntryRow.h"
#import "TextCell.h"
#import "TextRow.h"

@interface QuestionDetailViewModel ()

@property (strong, nonatomic) NSNumber *questionRemoteID;

@property (strong, nonatomic) NSManagedObjectContext *localContext;

@end

@implementation QuestionDetailViewModel

- (instancetype)initWithQuestionRemoteID:(NSNumber *)remoteID context:(NSManagedObjectContext *)context
{
    self = [super init];
    if (nil == self)
        return nil;

    self.questionRemoteID = remoteID;
    self.localContext = context;
    [self buildTableViewModel];

    return self;
}

- (QZQuestion *)question
{
    if (nil == _question) {
        _question = [QZQuestion MR_findFirstByAttribute:@"remoteID"
                                              withValue:_questionRemoteID
                                              inContext:self.localContext];
        if (nil == _question) {
            _question = [QZQuestion MR_createInContext:self.localContext];
            self.questionNew = YES;
            // mock data
//            _question.title = @"Runtime hacks";
//            _question.body = @"What are your favourite runtime hacks?";
        }
    }
    return _question;
}

- (void)buildTableViewModel
{
    DXTableViewSection *textSection = [[DXTableViewSection alloc] initWithName:@"Text"];

    // Title
    EntryRow *titleRow = [[EntryRow alloc] initWithCellReuseIdentifier:@"TitleCell"];
    titleRow.configureCellBlock = ^(DXTableViewRow *row, EntryCell *cell) {
        cell.textField.placeholder = NSLocalizedString(@"Title", @"Text field placeholder");
        cell.textField.textAlignment = NSTextAlignmentCenter;
    };
    [titleRow bindObject:self.question keyPaths:@[@"title"] toCellKeyPaths:@[@"textField.text"]];
    TextRow *bodyRow = [[TextRow alloc] initWithCellReuseIdentifier:@"BodyCell"];
    bodyRow.configureCellBlock = ^(DXTableViewRow *row, TextCell *cell) {
        cell.titleLabel.text = NSLocalizedString(@"Overview", @"Title for overview section of question form");
        cell.textView.font = [UIFont systemFontOfSize:14.0];
    };

    // Body / Overview
    bodyRow.rowHeight = 140.0;
    [bodyRow bindObject:self.question keyPaths:@[@"body"] toCellKeyPaths:@[@"textView.text"]];

    // Answer
    TextRow *answerRow = [[TextRow alloc] initWithCellReuseIdentifier:@"AnswerCell"];
    answerRow.configureCellBlock = ^(DXTableViewRow *row, TextCell *cell) {
        cell.titleLabel.text = NSLocalizedString(@"Answer", @"Title for answer section of question form");
        cell.textView.font = [UIFont systemFontOfSize:14.0];
    };
    answerRow.rowHeight = 80.0;
    [answerRow bindObject:self.question keyPaths:@[@"answer"] toCellKeyPaths:@[@"textView.text"]];

    // Bascket
    
    // Level

    // Field

    // Control

    [textSection addRow:titleRow];
    [textSection addRow:bodyRow];
    [textSection addRow:answerRow];
    for (DXTableViewRow *row in textSection.rows) {
        row.editingStyle = UITableViewCellEditingStyleNone;
        row.shouldIndentWhileEditingRow = NO;
    }

    [self addSection:textSection];
}

@end
