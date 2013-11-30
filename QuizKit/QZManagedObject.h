//
//  QZManagedObject.h
//  Quiz
//
//  Created by Alexander Ignatenko on 11/28/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface QZManagedObject : NSManagedObject


+ (id)createInContext:(NSManagedObjectContext *)context;

+ (NSString *)entityName;

+ (NSString *)demodulizedEntityName;

+ (NSString *)propertizeEntityName;

+ (NSString *)plurallyPropertizeEntityName;

@end
