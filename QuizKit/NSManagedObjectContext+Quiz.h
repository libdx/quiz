//
//  NSManagedObjectContext+Quiz.h
//  Quiz
//
//  Created by Alexander Ignatenko on 12/2/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (Quiz)

- (NSManagedObjectContext *)newMainQueueChildContext;

@end
