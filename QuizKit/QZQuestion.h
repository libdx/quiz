//
//  QZQuestion.h
//  Quiz
//
//  Created by Alexander Ignatenko on 9/5/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class QZReply, QZUser;

@interface QZQuestion : NSManagedObject

@property (nonatomic, retain) NSString * answer;
@property (nonatomic, retain) NSString * basket;
@property (nonatomic, retain) NSString * body;
@property (nonatomic, retain) NSNumber * control;
@property (nonatomic, retain) NSString * field;
@property (nonatomic, retain) NSNumber * level;
@property (nonatomic, retain) NSNumber * max;
@property (nonatomic, retain) NSNumber * min;
@property (nonatomic, retain) NSNumber * remoteID;
@property (nonatomic, retain) NSNumber * step;
@property (nonatomic, retain) id tags;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * value;
@property (nonatomic, retain) QZUser *owner;
@property (nonatomic, retain) NSSet *replies;
@end

@interface QZQuestion (CoreDataGeneratedAccessors)

- (void)addRepliesObject:(QZReply *)value;
- (void)removeRepliesObject:(QZReply *)value;
- (void)addReplies:(NSSet *)values;
- (void)removeReplies:(NSSet *)values;

@end
