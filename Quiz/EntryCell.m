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
    }
    return _titleLabel;
}

- (UITextField *)textField
{
    if (nil == _textField) {
        _textField = [[UITextField alloc] init];
    }
    return _textField;
}

- (NSArray *)components
{
    return @[self.titleLabel, self.textField];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    for (UIView *view in self.components) {
        if (view.superview != self.contentView)
            [self.contentView addSubview:view];
    }


    CGRect content = CGRectInset(self.contentView.frame, 10.0f, 0.0f);
    CGFloat amount = CGRectGetWidth(content) * 0.5;
    for (UIView *view in self.components) {
        CGRect slice;
        CGRect remainder;
        CGRectDivide(content, &slice, &remainder, amount, CGRectMinXEdge);
        content = remainder;
        view.frame = CGRectIntegral(slice);
    }
}

@end
