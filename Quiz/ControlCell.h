//
//  ControlCell.h
//  Quiz
//
//  Created by Alexander Ignatenko on 12/2/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol ControlCellDelegate;

@interface ControlCell : UITableViewCell

//@property (assign, nonatomic) QZControlType controlType;

@property (assign, nonatomic, getter=isEnabled) BOOL enabled;

@property (strong, nonatomic) UIView *controlView;
//@property (weak, nonatomic) id<ControlCellDelegate> delegate;

@end

//@protocol ControlCellDelegate <NSObject>
//
//- (UIView *)cell:(ControlCell *)cell controlViewForType:(QZControlType)type;
//
//@end
