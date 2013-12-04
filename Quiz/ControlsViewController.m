//
//  ControlsViewController.m
//  Quiz
//
//  Created by Alexander Ignatenko on 12/2/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "ControlsViewController.h"
#import "ArrayTableViewDataSource.h"
#import "BaseTableViewDelegate.h"
#import "ControlCell.h"

@interface ControlsViewController ()

@property (strong, nonatomic) QZQuestion *question;
@property (strong, nonatomic) NSManagedObjectContext *prototypesContext;
@property (strong, nonatomic) ArrayTableViewDataSource *dataSource;
@property (strong, nonatomic) BaseTableViewDelegate *delegate;

@end

@implementation ControlsViewController

- (instancetype)initWithQuestion:(QZQuestion *)quesion
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (nil == self)
        return nil;

    self.question = quesion;

    return self;
}

// Don't save this context. It's for prototype objects
- (NSManagedObjectContext *)prototypesContext
{
    if (nil == _prototypesContext)
        _prototypesContext = [self.question.managedObjectContext newMainQueueChildContext];
    return _prototypesContext;
}

- (NSArray *)prototypes
{
    NSMutableArray *prototypes = [NSMutableArray array];
    NSArray *types = @[@(QZControlTypeDiscret), @(QZControlTypeContinuous), @(QZControlTypeBinary)];
    for (NSNumber *type in types) {
        QZQuestion *question = [QZQuestion createInContext:self.prototypesContext];
        question.control = type;
        [prototypes addObject:question];
    }
    return prototypes;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    weakify(self, weak_self);

    self.dataSource = [[ArrayTableViewDataSource alloc] initWithTableView:self.tableView
                                                                    array:[self prototypes]
                                                           cellIdentifier:@"PrototypeControlCell"
                                                       configureCellBlock:
                       ^(UITableView *tableView, ControlCell *cell, NSIndexPath *indexPath, QZQuestion *prototype) {
                           strongify(self, weak_self);
                           cell.controlView = prototype.controlView;
                           cell.enabled = NO;
                           if ([self.question.control isEqualToNumber:prototype.control])
                               cell.accessoryType = UITableViewCellAccessoryCheckmark;
                           else
                               cell.accessoryType = UITableViewCellAccessoryNone;
                       }];

    self.delegate = [[BaseTableViewDelegate alloc] initWithTableView:self.tableView
                                                   didSelectRowBlock:
                     ^(UITableView *tableView, NSIndexPath *indexPath) {
                         strongify(self, weak_self);
                         self.question.control = [self.dataSource.array[indexPath.row] control];
                         [tableView reloadRowsAtIndexPaths:tableView.indexPathsForVisibleRows
                                          withRowAnimation:UITableViewRowAnimationFade];
                     }];

    [self.tableView registerClass:[ControlCell class] forCellReuseIdentifier:@"PrototypeControlCell"];
}

@end
