//
//  QuestionDetailsViewController.h
//  Quiz
//
//  Created by Alexander Ignatenko on 9/7/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "QuickDialogController.h"

@interface QuestionDetailsViewController : QuickDialogController

@property (strong, nonatomic) NSNumber *questionRemoteID;

- (id)initWithQuestionRemoteID:(NSNumber *)questionRemoteID;

@end
