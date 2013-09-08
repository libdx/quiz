//
//  UIViewController+Editing.h
//  Quiz
//
//  Created by Alexander Ignatenko on 9/8/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Editing)

@property (strong, nonatomic) NSManagedObjectContext *localContext;

- (NSManagedObjectContext *)setupLocalContextWithInstanceVariable:(NSManagedObjectContext *)ivar;

- (NSManagedObjectContext *)newLocalContext;

- (void)setupDoneAndCancelButtons;

- (void)setupDoneButtonWithActionBlock:(void (^)(id sender))doneBlock;

- (void)setupCancelButtonWithActionBlock:(void (^)(id sender))doneBlock;

- (void)save:(id)sender;

- (void)saveAndDismiss:(id)sender;

- (void)cancel:(id)sender;

- (void)cancelAndDismiss:(id)sender;

/**
 Override in subclasses.
 */
- (void)discardUnsavedChanges;

/**
 Override in subclasses.
 */
- (void)updateUI;

/**
 Override in subclasses.
 */
- (void)updateModel;

@end
