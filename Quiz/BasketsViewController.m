//
//  BasketsViewController.m
//  Quiz
//
//  Created by Alexander Ignatenko on 11/27/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "BasketsViewController.h"
#import "FetchedTableViewDataSource.h"
#import "BaseTableViewDelegate.h"
#import "EntryCell.h"

@interface BasketsViewController () <UITextFieldDelegate>

@property (strong, nonatomic) QZQuestion *question;
@property (strong, nonatomic) FetchedTableViewDataSource *dataSource;
@property (strong, nonatomic) BaseTableViewDelegate *delegate;
@property (strong, nonatomic) NSManagedObjectContext *localContext;
@property (strong, nonatomic) NSManagedObjectID *editingBasketID;
@property (copy, nonatomic) NSString *basketTitle;
@property (strong, nonatomic) NSIndexPath *editingIndexPath;

@end

@implementation BasketsViewController

- (instancetype)initWithQuestion:(QZQuestion *)question
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (nil == self)
        return nil;

    self.question = question;

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    weakify(self, weak_self);

    self.toolbarItems = [UIBarButtonItem creationBarItemsWithTarget:self action:@selector(addBasket)];

    NSFetchedResultsController *controller = [QZBasket MR_fetchAllSortedBy:@"updatedAt"
                                                                   ascending:NO
                                                               withPredicate:nil
                                                                     groupBy:nil
                                                                    delegate:nil
                                                                 inContext:self.localContext];

    self.dataSource = [[FetchedTableViewDataSource alloc] initWithTableView:self.tableView
                                                   fetchedResultsController:controller
                                                             cellIdentifier:@"BasketCell"
                                                         configureCellBlock:^(UITableView *tableView, EntryCell *cell, NSIndexPath *indexPath, QZBasket *basket)
    {
        if (NO == [basket.objectID isEqual:self.editingBasketID]) {
            cell.textField.text = basket.title;
            cell.textField.enabled = NO;
        } else {
            // Force edit for newly created basket object

            self.editingIndexPath = indexPath;

            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                                     initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                     target:self
                                                     action:@selector(cancel:)];

            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                                      initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                      target:self
                                                      action:@selector(done:)];

            cell.textField.text = nil;
            [cell.textField addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
            cell.textField.delegate = self;
            cell.textField.returnKeyType = UIReturnKeyDone;

            [cell.textField becomeFirstResponder];
        }

        if (nil != basket.question)
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        else
            cell.accessoryType = UITableViewCellAccessoryNone;
    }];
    self.dataSource.reloadRowOnUpdate = NO;

    self.delegate = [[BaseTableViewDelegate alloc] initWithTableView:self.tableView
                                                   didSelectRowBlock:^(UITableView *tableView, NSIndexPath *indexPath)
    {
        strongify(self, weak_self);

        QZBasket *basket = [controller objectAtIndexPath:indexPath];
        QZBasket *oldBasket = [self.question.basket MR_inContext:self.localContext];

        // assign basket object to question object in parent context (context of question)
        self.question.basket = [basket MR_inContext:self.question.managedObjectContext];

        // update basket object with changes from parent context
        [self.localContext refreshObject:basket mergeChanges:NO];
        // update previously selected basket from parent context (causes to remove checkmark)
        [self.localContext refreshObject:oldBasket mergeChanges:NO];

        // force to put or remove checkmark at or from the selected cell
        [tableView reloadRowsAtIndexPaths:tableView.indexPathsForVisibleRows withRowAnimation:UITableViewRowAnimationFade];
    }];

    [self.tableView registerClass:[EntryCell class] forCellReuseIdentifier:@"BasketCell"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden = NO;
}

- (void)addBasket
{
    QZBasket *basket = [QZBasket MR_createInContext:self.localContext];
    basket.createdAt = [NSDate date];
    basket.updatedAt = [NSDate date];
    self.editingBasketID = basket.objectID;
}

- (NSManagedObjectContext *)localContext
{
    if (nil == _localContext) {
        self.localContext = [NSManagedObjectContext MR_newMainQueueContext];
        self.localContext.parentContext = self.question.managedObjectContext;
    }
    return _localContext;
}

- (void)saveContext
{
    [self.localContext MR_saveOnlySelfWithCompletion:nil];
}

- (void)discardContext
{
    // balance created baskets
    for (NSManagedObject *object in self.localContext.insertedObjects)
         [self.localContext deleteObject:object];
}

- (void)resetNavigationBarButtonItems
{
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = nil;
}

- (BOOL)resignFirstResponder
{
    EntryCell *cell = (EntryCell *)[self.tableView cellForRowAtIndexPath:self.editingIndexPath];
    return [cell.textField resignFirstResponder];
}

#pragma mark - Actions

- (void)done:(id)sender
{
    // hide keyboard
    [self resignFirstResponder];

    NSIndexPath *editingIndexPath = self.editingIndexPath;

    // reset editing object and index path
    self.editingBasketID = nil; // must be nullify before updating basket object
    self.editingIndexPath = nil;

    // save text from text field
    QZBasket *basket = [self.dataSource.fetchedResultsController objectAtIndexPath:editingIndexPath];
    basket.title = self.basketTitle;
    self.basketTitle = nil;
    [self.tableView reloadRowsAtIndexPaths:@[editingIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

    // reset cancel and done buttons
    [self resetNavigationBarButtonItems];

    // save unsaved changes
    [self saveContext];
}

- (void)cancel:(id)sender
{
    // hide keyboard
    [self resignFirstResponder];

    // reset editing object and index path
    self.editingBasketID = nil;
    self.editingIndexPath = nil;

    // reset cancel and done buttons
    [self resetNavigationBarButtonItems];

    // delete unsaved changes
    [self discardContext];

}

- (void)textDidChange:(id)sender
{
    // cache title for basket
    self.basketTitle = [sender text];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self done:nil];
    return NO;
}

@end
