//
//  BaseTableViewDelegate.h
//  Quiz
//
//  Created by Alexander Ignatenko on 9/19/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewDelegate : NSObject <UITableViewDelegate>

@property (weak, nonatomic) UITableView *tableView;
@property (copy, nonatomic) void (^didSelectRowBlock)(UITableView *, NSIndexPath *);

- (instancetype)initWithTableView:(UITableView *)tableView
                didSelectRowBlock:(void (^)(UITableView *tableView, NSIndexPath *indexPath))didSelectRowBlock;

@end
