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

- (void)updateCell
{
    [super updateCell];
    self.tracker = [[TextViewValueTracker alloc] init];
    self.tracker.tag = @"textView.text";
    self.cell.textView.delegate = self.tracker;
    self.tracker.delegate = self;
}

#pragma mark - ValueTrackerDelegate

static void safeSetObjectForKey(NSMutableDictionary *dict, id object, id<NSCopying> key)
{
    if (nil != object)
        [dict setObject:object forKey:key];
    else
        [dict removeObjectForKey:key];
}

#pragma mark - ValueTrackerDelegate

- (void)valueTrackerDidTrackValue:(id<ValueTracker>)tracker
{
    [self.cellData safeSetObject:tracker.value forKey:tracker.tag];
}

@end
