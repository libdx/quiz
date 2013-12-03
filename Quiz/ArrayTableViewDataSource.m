//
//  ArrayTableViewDataSource.m
//  Quiz
//
//  Created by Alexander Ignatenko on 12/2/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "ArrayTableViewDataSource.h"

@implementation ArrayTableViewDataSource

- (instancetype)initWithTableView:(UITableView *)tableView
                            array:(NSArray *)array
                   cellIdentifier:(NSString *)cellIdentifier
               configureCellBlock:(void (^)(UITableView *tableView, id cell, NSIndexPath *indexPath, id object))configureCellBlock
{
    self = [super init];
    if (nil == self)
        return nil;

    self.tableView = tableView;
    self.array = array;
    self.cellIdentifier = cellIdentifier;
    self.configureCellBlock = configureCellBlock;

    // maybe setup KVO on array and/or array elements?
    _tableView.dataSource = self;

    return self;
}

#pragma makr - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    if (nil != self.configureCellBlock)
        self.configureCellBlock(tableView, cell, indexPath, _array[indexPath.row]);
    return cell;
}

@end
