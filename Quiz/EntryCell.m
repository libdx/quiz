//
//  EntryCell.m
//  Quiz
//
//  Created by Alexander Ignatenko on 9/19/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "EntryCell.h"

@implementation EntryCell

- (UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UITextField *)textField
{
    if (nil == _textField) {
        _textField = [[UITextField alloc] init];
        [self.contentView addSubview:_textField];
    }
    return _textField;
}

- (NSArray *)allComponents
{
    return @[self.titleLabel, self.textField];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    NSArray *components;
    if (nil != self.titleLabel.text)
        components = @[self.titleLabel, self.textField];
    else
        components = @[self.textField];

    CGRect content = CGRectInset(self.contentView.bounds, 10.0f, 0.0f);
    CGFloat amount = CGRectGetWidth(content) / components.count;
    for (UIView *view in components) {
        CGRect slice;
        CGRect remainder;
        CGRectDivide(content, &slice, &remainder, amount, CGRectMinXEdge);
        content = remainder;
        view.frame = CGRectIntegral(slice);
    }
}

@end
