//
//  QuestionDetailViewModel.m
//  Quiz
//
//  Created by Alexander Ignatenko on 9/19/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "QuestionDetailTable.h"
#import "EntryCell.h"
#import "TextCell.h"
#import "ControlCell.h"

@interface QuestionDetailTable ()

@property (strong, nonatomic) QZQuestion *question;

@end

@implementation QuestionDetailTable

- (instancetype)initWithQuestion:(QZQuestion *)question
{
    self = [super init];
    if (nil == self)
        return nil;

    self.question = question;
    [self buildTableViewModel];

    return self;
}

- (void)buildTableViewModel
{
    weakify(self, weak_self);

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
//    DXTableViewRow *stepperRow = [[DXTableViewRow alloc] initWithCellReuseIdentifier:@"StepperCell"];
//    stepperRow.cellNib = [UINib nibWithNibName:@"StepperCell" bundle:nil];
//    [stepperRow bindObject:self.question withKeyPaths:@[@"value"]];
//    stepperRow.configureCellBlock = ^(DXTableViewRow *row, StepperCell *cell) {
//        cell.titleLabel.text = @"Value";
//        cell.valueLabel.text = [NSString stringWithFormat:@"%@", row[@"value"]];
//        cell.stepper.value = [row[@"value"] doubleValue];
//        [row becomeTargetOfControl:cell.stepper forControlEvents:UIControlEventValueChanged withBlock:^(UIStepper *stepper){
//            row[@"value"] = @(stepper.value);
//            cell.valueLabel.text = [NSString stringWithFormat:@"%@", row[@"value"]];
//        }];
//    };

    // Pickup Section
    DXTableViewSection *pickupSection = [[DXTableViewSection alloc] initWithName:@"Pickup"];

    // Basket
    DXTableViewRow *basketRow = [[DXTableViewRow alloc] initWithCellReuseIdentifier:@"BascketCell"];
    basketRow.cellClass = [UITableViewCell class];
    [basketRow bindObject:self.question withKeyPath:@"basket.title"];
    basketRow.configureCellBlock = ^(DXTableViewRow *row, UITableViewCell *cell) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (nil != row[@"basket.title"])
            cell.textLabel.text = row[@"basket.title"];
        else
            cell.textLabel.text = NSLocalizedString(@"Basket", @"Text to be shown as a button title");
    };
    basketRow.didSelectRowBlock = ^(DXTableViewRow *row) {
        if ([_delegate respondsToSelector:@selector(questionDetailTableDidSelectBasketItem:)])
            [_delegate questionDetailTableDidSelectBasketItem:self];
    };

    // Level
//    DXTableViewRow *levelRow = [[DXTableViewRow alloc] initWithCellReuseIdentifier:@"LevelCell"];
//    levelRow.cellClass = [UITableViewCell class];
//    [levelRow bindObject:self.question withKeyPath:@"level"];
//    levelRow.configureCellBlock = ^(DXTableViewRow *row, UITableViewCell *cell) {
//        if (nil != row[@"level"])
//            cell.textLabel.text = [NSString stringWithFormat:@"%@", row[@"level"]];
//        else
//            cell.textLabel.text = NSLocalizedString(@"Level", @"Text to be shown as a button title");
//    };

    // Field
    DXTableViewRow *fieldRow = [[DXTableViewRow alloc] initWithCellReuseIdentifier:@"FieldCell"];
    fieldRow.cellClass = [UITableViewCell class];
    [fieldRow bindObject:self.question withKeyPath:@"field.title"];
    fieldRow.configureCellBlock = ^(DXTableViewRow *row, UITableViewCell *cell) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (nil != row[@"field.title"])
            cell.textLabel.text = row[@"field.title"];
        else
            cell.textLabel.text = NSLocalizedString(@"Field", @"Text to be shown as a button title");
    };
    fieldRow.didSelectRowBlock = ^(DXTableViewRow *row) {
        if ([_delegate respondsToSelector:@selector(questionDetailTableDidSelectFieldItem:)])
            [_delegate questionDetailTableDidSelectFieldItem:self];
    };

    // Control Section
    DXTableViewSection *controlSection = [[DXTableViewSection alloc] initWithName:@"Control"];

    // Control
    DXTableViewRow *controlRow = [[DXTableViewRow alloc] initWithCellReuseIdentifier:@"ControlCell"];
    controlRow.cellClass = [ControlCell class];
    [controlRow setConfigureCellBlock:^(DXTableViewRow *row, ControlCell *cell) {
        strongify(self, weak_self);
        cell.enabled = NO;
        if (self.question.control.integerValue == QZControlTypeNone) {
            cell.textLabel.text = NSLocalizedString(@"How to evaluate?", @"Menu item title");
        } else {
            cell.textLabel.text = nil;
            cell.controlView = self.question.controlView;
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }];
    [controlRow setDidSelectRowBlock:^(DXTableViewRow *row) {
        if ([_delegate respondsToSelector:@selector(questionDetailTableDidSelectControlItem:)])
            [_delegate questionDetailTableDidSelectControlItem:self];
    }];

//    [textSection addRows:@[titleRow, bodyRow, answerRow, stepperRow]];
//    [pickupSection addRows:@[basketRow, levelRow, fieldRow]];
    [textSection addRows:@[titleRow, bodyRow, answerRow,]];
    [pickupSection addRows:@[basketRow, fieldRow]];
    [controlSection addRow:controlRow];
    [self addSections:@[textSection, pickupSection, controlSection]];

//    for (DXTableViewSection *section in self.sections) {
//        for (DXTableViewRow *row in section.rows) {
//            row.editingStyle = UITableViewCellEditingStyleNone;
//            row.shouldIndentWhileEditingRow = NO;
//        }
//    }
}

@end