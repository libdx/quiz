//
//  ControlCell.m
//  Quiz
//
//  Created by Alexander Ignatenko on 12/2/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "ControlCell.h"

@interface ControlCell ()

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

- (void)setControlView:(UIControl *)controlView
{
    if(_controlView != controlView) {
        [_controlView removeFromSuperview];
        _controlView = controlView;
        [self.contentView addSubview:_controlView];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    [self.controlView sizeToFit];
    CGSize size = self.contentView.bounds.size;
    self.controlView.center = CGPointMake(floor(size.width * 0.5), floor(size.height * 0.5));
}

@end
