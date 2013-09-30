//
//  TextRow.h
//  Quiz
//
//  Created by Alexander Ignatenko on 9/22/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DXTableViewRow.h"

@class TextCell;

@interface TextRow : DXTableViewRow

@property (strong, nonatomic) TextCell *cell;

@property (copy, nonatomic) NSString *textViewValue;

@end
