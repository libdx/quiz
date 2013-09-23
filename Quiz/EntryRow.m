//
//  EntryRow.m
//  Quiz
//
//  Created by Alexander Ignatenko on 9/21/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "EntryRow.h"
#import "EntryCell.h"
#import "ValueTracker.h"

@interface EntryRow () <ValueTrackerDelegate>

@property (strong, nonatomic) TextFieldValueTracker *tracker;

@end

@implementation EntryRow

- (instancetype)initWithCellReuseIdentifier:(NSString *)identifier
{
    self = [super initWithCellReuseIdentifier:identifier];
    if (nil == self)
        return nil;

    self.cellClass = [EntryCell class];

    return self;
}

- (void)updateCell
{
    [super updateCell];
    if (nil == _tracker) {
        _tracker = [[TextFieldValueTracker alloc] init];
    }
    [_tracker trackValueOfTextField:self.cell.textField];
    _tracker.tag = @"textField.text";
    _tracker.delegate = self;
}

#pragma mark - ValueTrackerDelegate

- (void)valueTrackerDidTrackValue:(id<ValueTracker>)tracker
{
    [self.cellData safeSetObject:tracker.value forKey:tracker.tag];
}

@end
