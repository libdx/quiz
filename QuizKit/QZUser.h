//
//  QZUser.h
//  Quiz
//
//  Created by Alexander Ignatenko on 9/6/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class QZQuestion;

@interface QZUser : NSManagedObject

@property (nonatomic, retain) NSNumber * remoteID;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * token;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSDate * updatedAt;
@property (nonatomic, retain) NSSet *questions;
@end

@interface QZUser (CoreDataGeneratedAccessors)

- (void)addQuestionsObject:(QZQuestion *)value;
- (void)removeQuestionsObject:(QZQuestion *)value;
- (void)addQuestions:(NSSet *)values;
- (void)removeQuestions:(NSSet *)values;

@end

@interface QZUser (QuizKit)

+ (QZUser *)currentUser;

+ (void)setCurrentUser:(QZUser *)user;

@end
