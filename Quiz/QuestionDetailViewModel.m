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
#import "StepperCell.h"

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

    // Overview
    DXTableViewRow *bodyRow = [[DXTableViewRow alloc] initWithCellReuseIdentifier:@"BodyCell"];
    bodyRow.cellClass = [TextCell class];
    bodyRow.rowHeight = 140.0;
    [bodyRow bindObject:self.question withKeyPaths:@[@"overview"]];
    bodyRow.configureCellBlock = ^(DXTableViewRow *row, TextCell *cell) {
        cell.titleLabel.text = NSLocalizedString(@"Overview", @"Title for overview section of question form");
        cell.titleLabel.font = [UIFont systemFontOfSize:14.0];
        cell.titleLabel.textColor = [UIColor lightGrayColor];
        cell.textView.font = [UIFont systemFontOfSize:14.0];
        cell.textView.text = row[@"overview"];
        [row becomeDelegateOfTextViewForDidChange:cell.textView withBlock:^(UITextView *textView) {
            row[@"overview"] = textView.text;
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

    // Test with stepper
    DXTableViewRow *stepperRow = [[DXTableViewRow alloc] initWithCellReuseIdentifier:@"StepperCell"];
    stepperRow.cellNib = [UINib nibWithNibName:@"StepperCell" bundle:nil];
    [stepperRow bindObject:self.question withKeyPaths:@[@"value"]];
    stepperRow.configureCellBlock = ^(DXTableViewRow *row, StepperCell *cell) {
        cell.titleLabel.text = @"Value";
        cell.valueLabel.text = [NSString stringWithFormat:@"%@", row[@"value"]];
        cell.stepper.value = [row[@"value"] doubleValue];
        [row becomeTargetOfControl:cell.stepper forControlEvents:UIControlEventValueChanged withBlock:^(UIStepper *stepper){
            row[@"value"] = @(stepper.value);
            cell.valueLabel.text = [NSString stringWithFormat:@"%@", row[@"value"]];
        }];
    };

    // Pickup Section
    DXTableViewSection *pickupSection = [[DXTableViewSection alloc] initWithName:@"Pickup"];

    // Basket
    DXTableViewRow *basketRow = [[DXTableViewRow alloc] initWithCellReuseIdentifier:@"BascketCell"];
    basketRow.cellClass = [UITableViewCell class];
    [basketRow bindObject:self.question withKeyPath:@"basket"];
    basketRow.configureCellBlock = ^(DXTableViewRow *row, UITableViewCell *cell) {
        if (nil != row[@"basket"])
            cell.textLabel.text = row[@"basket"];
        else
            cell.textLabel.text = NSLocalizedString(@"Basket", @"Text to be shown as a button title");
    };
    basketRow.didSelectRowBlock = ^(DXTableViewRow *row) {
        if ([_delegate respondsToSelector:@selector(questionDetailViewModelDidSelectBasketItem:)])
            [_delegate questionDetailViewModelDidSelectBasketItem:self];
    };

    // Level
    DXTableViewRow *levelRow = [[DXTableViewRow alloc] initWithCellReuseIdentifier:@"LevelCell"];
    levelRow.cellClass = [UITableViewCell class];
    [levelRow bindObject:self.question withKeyPath:@"level"];
    levelRow.configureCellBlock = ^(DXTableViewRow *row, UITableViewCell *cell) {
        if (nil != row[@"level"])
            cell.textLabel.text = [NSString stringWithFormat:@"%@", row[@"level"]];
        else
            cell.textLabel.text = NSLocalizedString(@"Level", @"Text to be shown as a button title");
    };

    // Field
    DXTableViewRow *fieldRow = [[DXTableViewRow alloc] initWithCellReuseIdentifier:@"FieldCell"];
    fieldRow.cellClass = [UITableViewCell class];
    [fieldRow bindObject:self.question withKeyPath:@"field"];
    fieldRow.configureCellBlock = ^(DXTableViewRow *row, UITableViewCell *cell) {
        if (nil != row[@"field"])
            cell.textLabel.text = row[@"field"];
        else
            cell.textLabel.text = NSLocalizedString(@"Field", @"Text to be shown as a button title");
    };

    // Control Section
    //DXTableViewSection *controlSection = [[DXTableViewSection alloc] initWithName:@"Control"];

    // Control

    [textSection addRows:@[titleRow, bodyRow, answerRow, stepperRow]];
    [pickupSection addRows:@[basketRow, levelRow, fieldRow]];
    [self addSections:@[textSection, pickupSection]];

    for (DXTableViewSection *section in self.sections) {
        for (DXTableViewRow *row in section.rows) {
            row.editingStyle = UITableViewCellEditingStyleNone;
            row.shouldIndentWhileEditingRow = NO;
        }
    }
}

@end
