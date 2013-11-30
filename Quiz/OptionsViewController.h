//
//  OptionsViewController.h
//  Quiz
//
//  Created by Alexander Ignatenko on 11/30/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OptionsViewController : UITableViewController

@property (strong, nonatomic) QZQuestion *question;

@property (assign, nonatomic) BOOL allowMultipleSelection;

// `entityClass` must be subclass of `QZManagedObject`
- (instancetype)initWithStyle:(UITableViewStyle)style entityClass:(Class)entityClass;

@end
