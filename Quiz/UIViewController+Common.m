//
//  UIViewController+Common.m
//  Quiz
//
//  Created by Alexander Ignatenko on 9/6/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "UIViewController+Common.h"
#import "AppDelegate.h"
#import "Configuration.h"

@implementation UIViewController (Common)

- (AppDelegate *)appDelegate
{
    return [[UIApplication sharedApplication] delegate];
}

//- (id<Configuration>)configuration
//{
//    return [Configurations currentConfigurationForViewController:self];
//}

@end
