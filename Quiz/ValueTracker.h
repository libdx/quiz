//
//  ValueTracker.h
//  Quiz
//
//  Created by Alexander Ignatenko on 9/20/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ValueTracker;

@protocol ValueTrackerDelegate <NSObject>

- (void)valueTrackerDidTrackValue:(id<ValueTracker>)tracker;

@end

@protocol ValueTracker <NSObject>

@property (nonatomic, readonly) id value;
@property (copy, nonatomic) id tag;
@property (weak, nonatomic) id<ValueTrackerDelegate> delegate;

@end

@protocol TextValueTracker <ValueTracker>

@property (nonatomic, readonly) NSString *value;

@end

@interface TextViewValueTracker : NSObject <TextValueTracker, UITextViewDelegate>

@property (nonatomic) BOOL onlyTrackDidEndEditing;

@end

/**
 Assign `TextFieldValueTracker` object as delegate of a text field to track did end editing events only.
 Pass text field to a `trackValueOfTextField:` method to track text did change events.
 */
@interface TextFieldValueTracker : NSObject <TextValueTracker, UITextFieldDelegate>

// Has effect only when tracker is set as delegate of text field. Default is NO.
@property (nonatomic) BOOL resignFirstResponderOnReturnKey;

- (void)trackValueOfTextField:(UITextField *)textField;

@end

@interface ControlValueTracker : NSObject <ValueTracker>

- (void)trackValueOfControl:(UIControl *)control forKey:(NSString *)key controlEvents:(UIControlEvents)events;

@end
