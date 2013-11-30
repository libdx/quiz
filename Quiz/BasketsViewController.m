//
//  BasketsViewController.m
//  Quiz
//
//  Created by Alexander Ignatenko on 11/27/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "BasketsViewController.h"

@implementation BasketsViewController

- (instancetype)initWithQuestion:(QZQuestion *)question
{
    self = [super initWithStyle:UITableViewStylePlain entityClass:[QZBasket class]];
    if (nil == self)
        return nil;

    self.question = question;

    return self;
}

@end