//
//  ControlCell.m
//  Quiz
//
//  Created by Alexander Ignatenko on 12/2/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "ControlCell.h"

@interface ControlCell ()

//@property (strong, nonatomic) UIView *controlView;

@end

@implementation ControlCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (nil == self)
        return nil;

    self.enabled = YES;

    return self;
}

- (void)setEnabled:(BOOL)enabled
{
    _enabled = enabled;
    self.contentView.userInteractionEnabled = _enabled;
}

- (void)setControlView:(UIView *)controlView
{
    if(_controlView != controlView) {
        [_controlView removeFromSuperview];
        _controlView = controlView;
        [self.contentView addSubview:_controlView];
    }
}

//- (void)setControlType:(QZControlType)controlType
//{
//    if (_controlType != controlType || controlType == QZControlTypeNone) {
//        _controlType = controlType;
//        if (_controlType == QZControlTypeNone) {
//            self.textLabel.text = NSLocalizedString(@"How to evaluate?", @"Menu item title");
//        } else {
//            // add different subview
//            self.controlView = [_delegate cell:self controlViewForType:_controlType];
//            [self setNeedsLayout];
//        }
//    }
//}

- (void)layoutSubviews
{
    [super layoutSubviews];

    [self.controlView sizeToFit];
    CGSize size = self.contentView.bounds.size;
    self.controlView.center = CGPointMake(floor(size.width * 0.5), floor(size.height * 0.5));
}

@end
