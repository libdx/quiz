//
//  QZBasket.h
//  Quiz
//
//  Created by Alexander Ignatenko on 11/27/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class QZQuestion;

@interface QZBasket : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSNumber * remoteID;
@property (nonatomic, retain) NSDate * updatedAt;
@property (nonatomic, retain) QZQuestion *question;

@end
