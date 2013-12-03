//
//  ArrayTableViewDataSource.h
//  Quiz
//
//  Created by Alexander Ignatenko on 12/2/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArrayTableViewDataSource : NSObject <UITableViewDataSource>

@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *array;
@property (copy, nonatomic) NSString *cellIdentifier;
@property (copy, nonatomic) void (^configureCellBlock)(UITableView *tableView, id cell, NSIndexPath *indexPath, id object);

- (instancetype)initWithTableView:(UITableView *)tableView
                            array:(NSArray *)array
                   cellIdentifier:(NSString *)cellIdentifier
               configureCellBlock:(void (^)(UITableView *tableView, id cell, NSIndexPath *indexPath, id object))configureCellBlock;
@end
