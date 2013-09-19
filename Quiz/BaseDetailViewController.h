//
//  BaseDetailViewController.h
//  Quiz
//
//  Created by Alexander Ignatenko on 9/16/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseDetailViewController : UITableViewController

@property (copy, nonatomic) void (^dismissViewControllerBlock)(UIViewController *vc, BOOL didSave);

@property (nonatomic) BOOL shouldDismissOnSave;

@property (nonatomic) BOOL shouldDismissOnCancel;

- (void)save:(id)sender;

- (void)cancel:(id)sender;

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

@interface ManagedDetailViewController : BaseDetailViewController

@property (strong, nonatomic) NSManagedObjectContext *localContext;

@end
