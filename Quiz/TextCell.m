//
//  TextCell.m
//  Quiz
//
//  Created by Alexander Ignatenko on 9/22/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "TextCell.h"

@implementation TextCell

- (UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UITextView *)textView
{
    if (nil == _textView) {
        _textView = [[UITextView alloc] init];
        [self.contentView addSubview:_textView];
    }
    return _textView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    NSArray *components;
    if (nil != self.titleLabel.text)
        components = @[self.titleLabel, self.textView];
    else
        components = @[self.textView];

    CGRect content = CGRectInset(self.contentView.bounds, 10.0, 0);
    if (nil == self.titleLabel.text) {
        self.textView.frame = content;
    } else {
        [self.titleLabel sizeToFit];
        CGFloat amount = CGRectGetHeight(CGRectInset(self.titleLabel.frame, 0.0, -6.0));
        CGRect slice;
        CGRect remainder;
        CGRectDivide(content, &slice, &remainder, amount, CGRectMinYEdge);
        self.titleLabel.frame = CGRectIntegral(slice);
        self.textView.frame = CGRectIntegral(remainder);
    }
}

//- (void)setEditing:(BOOL)editing animated:(BOOL)animated
//{
//    [super setEditing:editing animated:animated];
//    self.textView.userInteractionEnabled = editing;
//}

@end
