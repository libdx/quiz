//
//  TextCell.m
//  Quiz
//
//  Created by Alexander Ignatenko on 9/22/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "TextCell.h"

@implementation TextCell

- (UITextView *)textView
{
    if (nil == _textView) {
        _textView = [[UITextView alloc] init];
    }
    return _textView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.textView.superview != self.contentView)
        [self.contentView addSubview:_textView];

    _textView.frame = CGRectInset(self.contentView.bounds, 10.0, 0);
}

@end
