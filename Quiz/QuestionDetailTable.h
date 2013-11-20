//
//  QuestionDetailViewModel.h
//  Quiz
//
//  Created by Alexander Ignatenko on 9/19/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "DXTableViewModel.h"

@protocol QuestionDetailTableDelegate;

@interface QuestionDetailTable : DXTableViewModel 

@property (weak, nonatomic) id<QuestionDetailTableDelegate> delegate;

- (instancetype)initWithQuestion:(QZQuestion *)question;

@end

@protocol QuestionDetailTableDelegate <NSObject>

@optional

- (void)questionDetailTableDidSelectBasketItem:(QuestionDetailTable *)table;
- (void)questionDetailTableDidSelectLevelItem:(QuestionDetailTable *)table;
- (void)questionDetailTableDidSelectFieldItem:(QuestionDetailTable *)table;
- (void)questionDetailTableDidSelectControlItem:(QuestionDetailTable *)table;

@end