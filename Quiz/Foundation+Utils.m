//
//  Foundation+Utils.m
//  Quiz
//
//  Created by Alexander Ignatenko on 9/22/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "Foundation+Utils.h"

@implementation NSMutableDictionary (Utils)

- (void)safeSetObject:(id)object forKey:(id<NSCopying>)key
{
    if (nil != object)
        [self setObject:object forKey:key];
    else
        [self removeObjectForKey:key];
}

@end
