//
//  QuestionRows.m
//  Quiz
//
//  Created by Alexander Ignatenko on 9/28/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "QuestionRows.h"

@implementation QuestionTitleRow

- (void)loadDataFromObject
{
    self.textFieldValue = self.boundObject.title;
}

- (void)updateObject
{
    self.boundObject.title = self.textFieldValue;
}

@end

@implementation QuestionBodyRow

- (void)loadDataFromObject
{
    self.textViewValue = self.boundObject.body;
}

- (void)updateObject
{
    self.boundObject.body = self.textViewValue;
}

@end

@implementation QuestionAnswerRow

- (void)loadDataFromObject
{
    self.textViewValue = self.boundObject.answer;
}

- (void)updateObject
{
    self.boundObject.answer = self.textViewValue;
}

@end
