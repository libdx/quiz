//
//  UIKit+Utils.m
//  Quiz
//
//  Created by Alexander Ignatenko on 11/2/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "UIKit+Utils.h"

@implementation UIBarButtonItem (Utils)

+ (UIBarButtonItem *)flexibleSpace
{
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL];
}

+ (NSArray *)creationBarItemsWithTarget:(id)target action:(SEL)action;
{
    NSMutableArray *items = [NSMutableArray array];
    [items addObject:[UIBarButtonItem flexibleSpace]];
    [items addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                   target:target
                                                                   action:action]];
    [items addObject:[UIBarButtonItem flexibleSpace]];
    return items;
}

@end
