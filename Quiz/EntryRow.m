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

- (void)didBindObject:(id)object withKeyPaths:(NSArray *)keyPaths
{
    NSString *keyPath = keyPaths[0];
    self.textFieldValue = [object valueForKeyPath:keyPath];
}

- (void)updateCell
{
    self.cell.textField.text = self.textFieldValue;
    if (nil == _tracker) {
        _tracker = [[TextFieldValueTracker alloc] init];
    }
    [_tracker trackValueOfTextField:self.cell.textField];
    _tracker.tag = @"textFieldValue";
    _tracker.delegate = self;
}

- (void)updateObject
{
    NSString *keyPath = self.boundKeyPaths[0];
    [self.boundObject setValue:self.textFieldValue forKeyPath:keyPath];
}

#pragma mark - ValueTrackerDelegate

- (void)valueTrackerDidTrackValue:(id<ValueTracker>)tracker
{
    [self setValue:tracker.value forKey:tracker.tag];
}

@end
