//
//  TextRow.m
//  Quiz
//
//  Created by Alexander Ignatenko on 9/22/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "TextRow.h"
#import "TextCell.h"
#import "ValueTracker.h"

@interface TextRow () <ValueTrackerDelegate>

@property (strong, nonatomic) TextViewValueTracker *tracker;

@end

@implementation TextRow

- (instancetype)initWithCellReuseIdentifier:(NSString *)identifier
{
    self = [super initWithCellReuseIdentifier:identifier];
    if (nil == self)
        return nil;

    self.cellClass = [TextCell class];

    return self;
}

- (void)didBindObject:(id)object withKeyPaths:(NSArray *)keyPaths
{
    NSString *keyPath = keyPaths[0];
    self.textViewValue = [object valueForKeyPath:keyPath];
}

- (void)updateCell
{
    self.cell.textView.text = self.textViewValue;
    if (nil == _tracker)
        self.tracker = [[TextViewValueTracker alloc] init];
    self.tracker.tag = @"textViewValue";
    self.cell.textView.delegate = self.tracker;
    self.tracker.delegate = self;
}

- (void)updateObject
{
    NSString *keyPath = self.boundKeyPaths[0];
    [self.boundObject setValue:self.textViewValue forKeyPath:keyPath];
}

#pragma mark - ValueTrackerDelegate

- (void)valueTrackerDidTrackValue:(id<ValueTracker>)tracker
{
    [self setValue:tracker.value forKey:tracker.tag];
}

@end
