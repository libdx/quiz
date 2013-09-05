//
//  QZUser.h
//  Quiz
//
//  Created by Alexander Ignatenko on 9/5/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class QZQuestion;

@interface QZUser : NSManagedObject

@property (nonatomic, retain) NSNumber * remoteID;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSSet *questions;
@end

@interface QZUser (CoreDataGeneratedAccessors)

- (void)addQuestionsObject:(QZQuestion *)value;
- (void)removeQuestionsObject:(QZQuestion *)value;
- (void)addQuestions:(NSSet *)values;
- (void)removeQuestions:(NSSet *)values;

@end
