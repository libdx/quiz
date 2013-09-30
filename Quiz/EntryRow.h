//
//  EntryRow.h
//  Quiz
//
//  Created by Alexander Ignatenko on 9/21/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "DXTableViewRow.h"

@class EntryCell;

@interface EntryRow : DXTableViewRow

@property (nonatomic, readonly) EntryCell *cell;

@property (copy, nonatomic) NSString *textFieldValue;

@end
