//
//  ValueTracker.m
//  Quiz
//
//  Created by Alexander Ignatenko on 9/20/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "ValueTracker.h"

@interface TextViewValueTracker ()
@property (strong, nonatomic) NSString *value;
@end

@implementation TextViewValueTracker

@synthesize tag = _tag;
@synthesize delegate = _delegate;

- (void)textViewDidChange:(UITextView *)textView
{
    if (_onlyTrackDidEndEditing)
        return;

    _value = textView.text;
    [_delegate valueTrackerDidTrackValue:self];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    _value = textView.text;
    [_delegate valueTrackerDidTrackValue:self];
}

@end

@interface TextFieldValueTracker ()
@property (strong, nonatomic) NSString *value;
@end

@implementation TextFieldValueTracker

@synthesize tag = _tag;
@synthesize delegate = _delegate;

- (instancetype)init
{
    self = [super init];
    if (nil == self)
        return nil;

    _resignFirstResponderOnReturnKey = NO;

    return self;
}

- (void)trackValueOfTextField:(UITextField *)textField
{
    [textField addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textDidChange:(id)sender
{
    _value = [sender text];
    [_delegate valueTrackerDidTrackValue:self];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _value = textField.text;
    [_delegate valueTrackerDidTrackValue:self];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    BOOL res = YES;
    if (self.resignFirstResponderOnReturnKey) {
        [textField resignFirstResponder];
        res = NO;
    }
    return res;
}

@end

@interface ControlValueTracker ()
{
    NSString *_controlKey;
}

@property (strong, nonatomic) id value;

@end

@implementation ControlValueTracker

@synthesize tag = _tag;
@synthesize delegate = _delegate;

- (void)trackValueOfControl:(UIControl *)control forKey:(NSString *)key controlEvents:(UIControlEvents)events
{
    _controlKey = key;
    [control addTarget:self action:@selector(valueDidChange:) forControlEvents:events];
}

- (void)valueDidChange:(id)sender
{
    _value = [sender valueForKey:_controlKey];
    [_delegate valueTrackerDidTrackValue:self];
}

@end
