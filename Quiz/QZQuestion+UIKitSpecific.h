//
//  QZQuestion+UIKitSpecific.h
//  Quiz
//
//  Created by Alexander Ignatenko on 12/2/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "QZQuestion.h"

@interface QZQuestion (UIKitSpecific)

//+ (UIView *)controlViewForType:(QZControlType)type;

- (UIView *)controlView;

@end
