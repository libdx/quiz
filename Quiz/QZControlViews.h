//
//  QZControlViews.h
//  Quiz
//
//  Created by Alexander Ignatenko on 12/2/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QZControlViews : NSObject

+ (UIView *)viewForType:(QZControlType)type;
+ (UIView *)viewForType:(QZControlType)type question:(QZQuestion *)question;

@end
