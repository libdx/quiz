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

@end
