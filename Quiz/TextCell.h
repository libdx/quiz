//
//  TextCell.h
//  Quiz
//
//  Created by Alexander Ignatenko on 9/22/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UITextView *textView;

@end
