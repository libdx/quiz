//
//  QZQuestion+UIKitSpecific.m
//  Quiz
//
//  Created by Alexander Ignatenko on 12/2/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "QZQuestion+UIKitSpecific.h"

@implementation QZQuestion (UIKitSpecific)

- (UIView *)controlView
{
    UIView *view;
    switch ((QZControlType)self.control.integerValue) {
        case QZControlTypeDiscret: {
            view = [self discretControlView];
            break;
        }
        case QZControlTypeContinuous: {
            view = [self continuousControlView];
            break;
        }
        case QZControlTypeBinary: {
            view = [self binaryControlView];
        }

        default:
            break;
    }
    return view;
}

- (UIView *)discretControlView
{
    NSMutableArray *items = [NSMutableArray array];
    for (double i = self.min.doubleValue; i < self.max.doubleValue; i += self.step.doubleValue) {
        [items addObject:[NSString stringWithFormat:@"%@", @(i)]];
    }
    UISegmentedControl *sc = [[UISegmentedControl alloc] initWithItems:items];
    return sc;
}

- (UIView *)continuousControlView
{
    UISlider *slider = [[UISlider alloc] init];
    slider.maximumValue = self.max.floatValue;
    slider.minimumValue = self.min.floatValue;
    return slider;
}

- (UIView *)binaryControlView
{
    NSArray *items = @[@"Correct", @"Incorrect"];
    UISegmentedControl *sc = [[UISegmentedControl alloc] initWithItems:items];
    return sc;
}

@end
