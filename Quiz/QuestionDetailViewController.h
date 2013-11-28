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

@property (strong, nonatomic) NSManagedObjectID *questionID;

- (id)initWithQuestionID:(NSManagedObjectID *)questionID;

@end
