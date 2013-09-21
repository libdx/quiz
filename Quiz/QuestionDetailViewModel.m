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
    DXTableViewRow *titleRow = [[EntryRow alloc] initWithCellReuseIdentifier:@"TitleRow"];
    titleRow.configureCellBlock = ^(DXTableViewRow *row, EntryCell *cell) {
        cell.textField.placeholder = @"Title";
        cell.textField.textAlignment = NSTextAlignmentCenter;
    };
    [titleRow bindObject:self.question keyPaths:@[@"title"] toCellKeyPaths:@[@"textField.text"]];
    titleRow.editingStyle = UITableViewCellEditingStyleNone;
    titleRow.shouldIndentWhileEditingRow = NO;
    [textSection addRow:titleRow];
    [self addSection:textSection];
}

@end
