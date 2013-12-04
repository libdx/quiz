//
//  ControlCell.h
//  Quiz
//
//  Created by Alexander Ignatenko on 12/2/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ControlCell : UITableViewCell

@property (assign, nonatomic, getter=isEnabled) BOOL enabled;

@property (strong, nonatomic) UIControl *controlView;

@end
