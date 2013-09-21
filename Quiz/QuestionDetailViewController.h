//
//  QuestionDetailViewController.h
//  Quiz
//
//  Created by Alexander Ignatenko on 9/7/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "QuickDialogController.h"
#import "BaseDetailViewController.h"

@interface QuestionDetailViewController : ManagedDetailViewController

@property (strong, nonatomic) NSNumber *questionRemoteID;

- (id)initWithQuestionRemoteID:(NSNumber *)questionRemoteID;

@end