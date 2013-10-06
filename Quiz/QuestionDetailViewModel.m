//
//  QuestionDetailViewModel.m
//  Quiz
//
//  Created by Alexander Ignatenko on 9/19/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "QuestionDetailViewModel.h"
#import "EntryCell.h"
#import "TextCell.h"
#import "EntryRow.h"
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
    DXTableViewRow *titleRow = [[DXTableViewRow alloc] initWithCellReuseIdentifier:@"TitleCell"];
    titleRow.cellClass = [EntryCell class];
    [titleRow bindObject:self.question withKeyPaths:@[@"title"]];
    titleRow.configureCellBlock = ^(DXTableViewRow *row, EntryCell *cell) {
        cell.textField.placeholder = NSLocalizedString(@"Title", @"Text field placeholder");
        cell.textField.textAlignment = NSTextAlignmentCenter;
        cell.textField.text = row[@"title"]; // or row.boundObjectData[@"title"];
        [row becomeTargetOfTextFieldForEditingChanged:cell.textField withBlock:^(UITextField *textField){
            row[@"title"] = textField.text;
        }];
    };

    // Body / Overview
    DXTableViewRow *bodyRow = [[DXTableViewRow alloc] initWithCellReuseIdentifier:@"BodyCell"];
    bodyRow.cellClass = [TextCell class];
    bodyRow.rowHeight = 140.0;
    [bodyRow bindObject:self.question withKeyPaths:@[@"body"]];
    bodyRow.configureCellBlock = ^(DXTableViewRow *row, TextCell *cell) {
        cell.titleLabel.text = NSLocalizedString(@"Overview", @"Title for overview section of question form");
        cell.titleLabel.font = [UIFont systemFontOfSize:14.0];
        cell.titleLabel.textColor = [UIColor lightGrayColor];
        cell.textView.font = [UIFont systemFontOfSize:14.0];
        cell.textView.text = row[@"body"];
        [row becomeDelegateOfTextViewForDidChange:cell.textView withBlock:^(UITextView *textView) {
            row[@"body"] = textView.text;
        }];
    };

    // Answer
    DXTableViewRow *answerRow = [[DXTableViewRow alloc] initWithCellReuseIdentifier:@"AnswerCell"];
    answerRow.cellClass = [TextCell class];
    answerRow.rowHeight = 80.0;
    [answerRow bindObject:self.question withKeyPaths:@[@"answer"]];
    answerRow.configureCellBlock = ^(DXTableViewRow *row, TextCell *cell) {
        cell.titleLabel.text = NSLocalizedString(@"Answer", @"Title for answer section of question form");
        cell.titleLabel.font = [UIFont systemFontOfSize:14.0];
        cell.titleLabel.textColor = [UIColor lightGrayColor];
        cell.textView.font = [UIFont systemFontOfSize:14.0];
        cell.textView.text = row[@"answer"];
        [row becomeDelegateOfTextViewForDidChange:cell.textView withBlock:^(UITextView *textView) {
            row[@"answer"] = textView.text;
        }];
    };

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
