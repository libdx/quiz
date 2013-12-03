//
//  NSManagedObjectContext+Quiz.m
//  Quiz
//
//  Created by Alexander Ignatenko on 12/2/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "NSManagedObjectContext+Quiz.h"

@implementation NSManagedObjectContext (Quiz)

- (NSManagedObjectContext *)newMainQueueChildContext
{
    NSManagedObjectContext *ctx = [NSManagedObjectContext MR_newMainQueueContext]; // to use MR logging
    ctx.parentContext = self;
    return ctx;
}

@end
