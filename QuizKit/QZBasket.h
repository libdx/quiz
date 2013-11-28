//
//  QZBasket.h
//  Quiz
//
//  Created by Alexander Ignatenko on 11/27/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "QZManagedObject.h"

@class QZQuestion;

@interface QZBasket : QZManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSNumber * remoteID;
@property (nonatomic, retain) NSDate * updatedAt;
@property (nonatomic, retain) NSSet *questions;
@end


@interface QZBasket (CoreDataGeneratedAccessors)

- (void)addQuestionsObject:(QZQuestion *)value;
- (void)removeQuestionsObject:(QZQuestion *)value;
- (void)addQuestions:(NSSet *)values;
- (void)removeQuestions:(NSSet *)values;

@end