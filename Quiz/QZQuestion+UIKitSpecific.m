//
//  QZQuestion+UIKitSpecific.m
//  Quiz
//
//  Created by Alexander Ignatenko on 12/2/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "QZQuestion+UIKitSpecific.h"

@implementation QZQuestion (UIKitSpecific)

- (UIControl *)controlView
{
    UIControl *control;
    switch ((QZControlType)self.control.integerValue) {
        case QZControlTypeDiscret: {
            control = [self discretControlView];
            break;
        }
        case QZControlTypeContinuous: {
            control = [self continuousControlView];
            break;
        }
        case QZControlTypeBinary: {
            control = [self binaryControlView];
        }

        default:
            break;
    }
    return control;
}

- (UIControl *)discretControlView
{
    NSMutableArray *items = [NSMutableArray array];
    for (double i = self.min.doubleValue; i <= self.max.doubleValue; i += self.step.doubleValue) {
        [items addObject:[NSString stringWithFormat:@"%@", @(i)]];
    }
    UISegmentedControl *sc = [[UISegmentedControl alloc] initWithItems:items];
    return sc;
}

- (UIControl *)continuousControlView
{
    UISlider *slider = [[UISlider alloc] init];
    slider.maximumValue = self.max.floatValue;
    slider.minimumValue = self.min.floatValue;
    slider.value = floor(0.5 * (slider.maximumValue - slider.minimumValue));
    return slider;
}

- (UIControl *)binaryControlView
{
    NSArray *items = @[@"Correct", @"Incorrect"];
    UISegmentedControl *sc = [[UISegmentedControl alloc] initWithItems:items];
    return sc;
}

@end
