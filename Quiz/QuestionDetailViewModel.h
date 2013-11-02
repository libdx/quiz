//
//  QuestionDetailViewModel.h
//  Quiz
//
//  Created by Alexander Ignatenko on 9/19/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "DXTableViewModel.h"

@protocol QuestionDetailViewModelDelegate;

@interface QuestionDetailViewModel : DXTableViewModel

@property (weak, nonatomic) id<QuestionDetailViewModelDelegate> delegate;

@property (strong, nonatomic) QZQuestion *question;

@property (nonatomic, getter=isQuestionNew) BOOL questionNew;

- (instancetype)initWithQuestionRemoteID:(NSNumber *)remoteID context:(NSManagedObjectContext *)context;

@end

@protocol QuestionDetailViewModelDelegate <NSObject>

@optional

- (void)questionDetailViewModelDidSelectBasketItem:(QuestionDetailViewModel *)viewModel;
- (void)questionDetailViewModelDidSelectLevelItem:(QuestionDetailViewModel *)viewModel;
- (void)questionDetailViewModelDidSelectFieldItem:(QuestionDetailViewModel *)viewModel;
- (void)questionDetailViewModelDidSelectControlItem:(QuestionDetailViewModel *)viewModel;

@end
