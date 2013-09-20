//
//  QuestionDetailViewModel.m
//  Quiz
//
//  Created by Alexander Ignatenko on 9/19/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "QuestionDetailViewModel.h"
#import "EntryCell.h"

@interface QuestionDetailTitleRow : DXTableViewRow

@property (strong, nonatomic) NSString *titleValue;
@property (strong, nonatomic) NSString *fieldValue;

- (instancetype)init;

@end

@implementation QuestionDetailTitleRow

- (instancetype)init
{
    self = [super initWithCellReuseIdentifier:@"TitleCell"];
    if (nil == self)
        return nil;

    self.cellClass = [EntryCell class];

    return self;
}

@end

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
            // mock data
            _question.title = @"Runtime hacks";
            _question.body = @"What are your favourite runtime hacks?";
            self.questionNew = YES;
        }
    }
    return _question;
}

- (void)buildTableViewModel
{
    __weak typeof(self) weak_self = self;

    DXTableViewSection *textSection = [[DXTableViewSection alloc] initWithName:@"Text"];
    DXTableViewRow *titleRow = [[DXTableViewRow alloc] initWithCellReuseIdentifier:@"TitleRow"];
    titleRow.cellClass = [EntryCell class];
    titleRow.boundObject = self.question;
    titleRow.configureCellBlock = ^(DXTableViewRow *row, EntryCell *cell) {
//        cell.textLabel.text = weak_self.question.title;
        cell.titleLabel.text = @"Title";
        cell.textField.placeholder = @"Title";
        cell.textField.text = [row.boundObject title];
    };
    titleRow.editingStyle = UITableViewCellEditingStyleNone;
    titleRow.shouldIndentWhileEditingRow = NO;
    [textSection addRow:titleRow];
    [self addSection:textSection];
}

@end
