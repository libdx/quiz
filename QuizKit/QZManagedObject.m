//
//  QZManagedObject.m
//  Quiz
//
//  Created by Alexander Ignatenko on 11/28/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "QZManagedObject.h"

@implementation QZManagedObject

+ (id)createEntity
{
	NSManagedObject *newEntity = [self createInContext:[NSManagedObjectContext MR_contextForCurrentThread]];
    return newEntity;
}

+ (id)createInContext:(NSManagedObjectContext *)context
{
    return [self MR_createInContext:context];
}

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

+ (NSString *)entityName
{
    return NSStringFromClass(self);
}

+ (NSString *)demodulizedEntityName
{

    NSRange range = [[self entityName] rangeOfString:@"QZ"];
    return [[self entityName] substringFromIndex:NSMaxRange(range)];
}

+ (NSString *)propertizeEntityName
{
    return [[self demodulizedEntityName] lowercaseString];
}

+ (NSString *)plurallyPropertizeEntityName
{
    [NSException raise:NSInternalInconsistencyException format:@"Override %@ method in subclasses", NSStringFromSelector(_cmd)];
    return nil;
}

@end
