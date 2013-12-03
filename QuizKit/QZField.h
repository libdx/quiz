//
//  QZField.h
//  Quiz
//
//  Created by Alexander Ignatenko on 12/1/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "QZManagedObject.h"

@class QZQuestion, QZUser;

@interface QZField : QZManagedObject

@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSNumber * remoteID;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * updatedAt;
@property (nonatomic, retain) NSSet *questions;
@property (nonatomic, retain) QZUser *user;
@end

@interface QZField (CoreDataGeneratedAccessors)

- (void)addQuestionsObject:(QZQuestion *)value;
- (void)removeQuestionsObject:(QZQuestion *)value;
- (void)addQuestions:(NSSet *)values;
- (void)removeQuestions:(NSSet *)values;

@end
