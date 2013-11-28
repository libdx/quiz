//
//  QZManagedObject.m
//  Quiz
//
//  Created by Alexander Ignatenko on 11/28/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "QZManagedObject.h"

@implementation QZManagedObject

+ (id)MR_createInContext:(NSManagedObjectContext *)context
{
    NSManagedObject *object = [super MR_createInContext:context];
    if ([object respondsToSelector:@selector(setUser:)]) {
        [object setValue:[[QZUser currentUser] MR_inContext:context] forKey:@"user"];
    }
    [object setValue:[NSDate date] forKey:@"createdAt"];
    [object setValue:[NSDate date] forKey:@"updatedAt"];
    return object;
}

@end
