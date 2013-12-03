//
//  QZControlViews.m
//  Quiz
//
//  Created by Alexander Ignatenko on 12/2/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "QZControlViews.h"

@implementation QZControlViews

+ (UIView *)viewForType:(QZControlType)type
{
    return [self viewForType:type question:nil];
}

+ (UIView *)viewForType:(QZControlType)type question:(QZQuestion *)question
{
    UIView *view;
    switch ((QZControlType)question.control.integerValue) {
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

//+ (UIView *)viewForType:(QZControlType)type min:(double)min max:(double)max step:(double)step
//{
//
//}

//    return [self viewForType:type
//                         min:question.min.integerValue
//                         max:question.max.integerValue
//                        step:question.step.integerValue];

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
