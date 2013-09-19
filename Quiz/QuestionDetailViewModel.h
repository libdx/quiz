//
//  QuestionDetailViewModel.h
//  Quiz
//
//  Created by Alexander Ignatenko on 9/19/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "DXTableViewModel.h"

@interface QuestionDetailViewModel : DXTableViewModel

@property (strong, nonatomic) QZQuestion *question;

@property (nonatomic, getter=isQuestionNew) BOOL questionNew;

- (instancetype)initWithQuestionRemoteID:(NSNumber *)remoteID context:(NSManagedObjectContext *)context;

@end
