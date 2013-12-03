//
//  FieldsViewController.m
//  Quiz
//
//  Created by Alexander Ignatenko on 12/1/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "FieldsViewController.h"

@interface FieldsViewController ()

@end

@implementation FieldsViewController

- (instancetype)initWithQuestion:(QZQuestion *)question
{
    self = [super initWithStyle:UITableViewStylePlain entityClass:[QZField class]];
    if (nil == self)
        return nil;

    self.question = question;

    return self;
}

@end
