//
//  QZReply.h
//  Quiz
//
//  Created by Alexander Ignatenko on 9/6/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "QZManagedObject.h"

@class QZQuestion;

@interface QZReply : QZManagedObject

@property (nonatomic, retain) NSNumber * mark;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSNumber * remoteID;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSDate * updatedAt;
@property (nonatomic, retain) QZQuestion *question;

@end
