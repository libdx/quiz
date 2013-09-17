//
//  DetailViewController.h
//  Quiz
//
//  Created by Alexander Ignatenko on 9/16/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UITableViewController

@property (copy, nonatomic) void (^dismissViewControllerBlock)(UIViewController *vc, BOOL didSave);

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

@interface ManagedDetailViewController : DetailViewController

@property (strong, nonatomic) NSManagedObjectContext *localContext;

@end
