//
//  BaseTableViewDelegate.m
//  Quiz
//
//  Created by Alexander Ignatenko on 9/19/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "BaseTableViewDelegate.h"

@implementation BaseTableViewDelegate

- (instancetype)initWithTableView:(UITableView *)tableView didSelectRowBlock:(void (^)(NSIndexPath *indexPath))didSelectRowBlock
{
    self = [super init];
    if (nil == self)
        return nil;

    self.didSelectRowBlock = didSelectRowBlock;
    self.tableView = tableView;
    self.tableView.delegate = self;

    return self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (nil != self.didSelectRowBlock)
        self.didSelectRowBlock(indexPath);
}


@end
