//
//  LoginViewModel.h
//  Quiz
//
//  Created by Alexander Ignatenko on 10/18/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "DXTableViewModel.h"

@interface LoginTable : DXTableViewModel

@property (copy, nonatomic, readonly) NSString *username;
@property (copy, nonatomic, readonly) NSString *password;

@property (weak, nonatomic) id signInTarget;
@property (nonatomic) SEL signInAction;

@property (weak, nonatomic) id signUpTarget;
@property (nonatomic) SEL signUpAction;

@end
