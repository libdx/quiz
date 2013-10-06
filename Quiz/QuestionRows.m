//
//  QuestionRows.m
//  Quiz
//
//  Created by Alexander Ignatenko on 9/28/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "QuestionRows.h"
#import "EntryCell.h"
#import "TextCell.h"

@implementation QuestionTitleRow

- (void)didBindObject
{
    self.textFieldValue = self.boundObject.title;
}

//- (void)updateCell
//{
//    [super updateCell];
//    self.cell.textField.textAlignment = NSTextAlignmentCenter;
//}

- (void)updateObject
{
    self.boundObject.title = self.textFieldValue;
}

@end

@implementation QuestionBodyRow

- (void)didBindObject
{
    self.textViewValue = self.boundObject.body;
}

//- (void)updateCell
//{
//    [super updateCell];
//    self.cell.titleLabel.font = [UIFont systemFontOfSize:14.0];
//    self.cell.titleLabel.textColor = [UIColor lightGrayColor];
//    self.cell.textView.font = [UIFont systemFontOfSize:14.0];
//}

- (void)updateObject
{
    self.boundObject.body = self.textViewValue;
}

@end

@implementation QuestionAnswerRow

- (void)didBindObject
{
    self.textViewValue = self.boundObject.answer;
}

//- (void)updateCell
//{
//    [super updateCell];
//    self.cell.titleLabel.font = [UIFont systemFontOfSize:14.0];
//    self.cell.titleLabel.textColor = [UIColor lightGrayColor];
//    self.cell.textView.font = [UIFont systemFontOfSize:14.0];
//}

- (void)updateObject
{
    self.boundObject.answer = self.textViewValue;
}

@end
