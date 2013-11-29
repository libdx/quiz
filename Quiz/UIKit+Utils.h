//
//  UIKit+Utils.h
//  Quiz
//
//  Created by Alexander Ignatenko on 11/2/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//



@interface UIBarButtonItem (Utils)

+ (UIBarButtonItem *)flexibleSpace;

+ (NSArray *)creationBarItemsWithTarget:(id)target action:(SEL)action;

@end

@interface UITextField (Utils)

- (UITextField *)configureUsernameField;
- (UITextField *)configureSecureField;

@end
