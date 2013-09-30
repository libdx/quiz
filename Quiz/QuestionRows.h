//
//  QuestionRows.h
//  Quiz
//
//  Created by Alexander Ignatenko on 9/28/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EntryRow.h"
#import "TextRow.h"

@interface QuestionTitleRow : EntryRow

@property (strong, nonatomic) QZQuestion *boundObject;

@end

@interface QuestionBodyRow : TextRow

@property (strong, nonatomic) QZQuestion *boundObject;

@end

@interface QuestionAnswerRow : TextRow

@property (strong, nonatomic) QZQuestion *boundObject;

@end