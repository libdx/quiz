//
//  QZQuestion.m
//  Quiz
//
//  Created by Alexander Ignatenko on 9/6/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "QZQuestion.h"
#import "QZReply.h"
#import "QZUser.h"


@implementation QZQuestion

@dynamic answer;
@dynamic basket;
@dynamic overview;
@dynamic control;
@dynamic field;
@dynamic level;
@dynamic max;
@dynamic min;
@dynamic remoteID;
@dynamic step;
@dynamic tags;
@dynamic title;
@dynamic value;
@dynamic createdAt;
@dynamic updatedAt;
@dynamic user;
@dynamic replies;

@end

@implementation QZQuestion (QuizKit)

- (void)awakeFromInsert
{
    [super awakeFromInsert];
    [self setPrimitiveValue:@(QZControlTypeNone) forKey:@"control"];
}

- (void)setControl:(NSNumber *)control
{
    [self willChangeValueForKey:@"control"];
    [self setPrimitiveValue:control forKey:@"control"];
    switch ((QZControlType)control.integerValue) {
        case QZControlTypeDiscret:
            self.min = @1.0;
            self.max = @5.0;
            self.step = @1.0;
            break;

        case QZControlTypeContinuous:
            self.min = @0.0;
            self.max = @100.0;
            self.step = @0; // Not specified
            break;

        case QZControlTypeBinary:
            self.min = @0;
            self.max = @1;
            self.step = @1;

        case QZControlTypeNone:
            self.min = @0;
            self.max = @0;
            self.step = @0;

        default:
            break;
    }
    [self didChangeValueForKey:@"control"];
}

@end
