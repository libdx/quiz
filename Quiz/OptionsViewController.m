//
//  OptionsViewController.m
//  Quiz
//
//  Created by Alexander Ignatenko on 11/30/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "OptionsViewController.h"
#import "FetchedTableViewDataSource.h"
#import "BaseTableViewDelegate.h"
#import "EntryCell.h"

@interface OptionsViewController () <UITextFieldDelegate>

@property (strong, nonatomic) FetchedTableViewDataSource *dataSource;
@property (strong, nonatomic) BaseTableViewDelegate *delegate;
@property (strong, nonatomic) NSManagedObjectContext *localContext;
@property (strong, nonatomic) NSManagedObjectID *editingEntityID;
@property (copy, nonatomic) NSString *entityTitle;
@property (strong, nonatomic) NSIndexPath *editingIndexPath;

@property (unsafe_unretained, nonatomic) Class entityClass;

@end

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation OptionsViewController

- (instancetype)initWithStyle:(UITableViewStyle)style entityClass:(Class)entityClass
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (nil == self)
        return nil;

    self.entityClass = entityClass;

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    weakify(self, weak_self);

    self.toolbarItems = [UIBarButtonItem creationBarItemsWithTarget:self action:@selector(addEntity)];

    NSFetchedResultsController *controller = [self.entityClass MR_fetchAllSortedBy:@"updatedAt"
                                                                         ascending:NO
                                                                     withPredicate:nil
                                                                           groupBy:nil
                                                                          delegate:nil
                                                                         inContext:self.localContext];

    self.dataSource = [[FetchedTableViewDataSource alloc] initWithTableView:self.tableView
                                                   fetchedResultsController:controller
                                                             cellIdentifier:[self entityCellID]
                                                         configureCellBlock:^(UITableView *tableView, EntryCell *cell, NSIndexPath *indexPath, id entity)
    {
        if (NO == [[entity objectID] isEqual:self.editingEntityID]) {
            cell.textField.text = [entity title];
            cell.textField.enabled = NO;
        } else {
            // Force edit for newly created entity object

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

            if (NO == [cell.textField becomeFirstResponder])
                LogError(@"Text field can't become first responder");
        }

        if ([[entity questions] containsObject:self.question])
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        else
            cell.accessoryType = UITableViewCellAccessoryNone;
    }];
    self.dataSource.reloadRowOnUpdate = NO;

    self.delegate = [[BaseTableViewDelegate alloc] initWithTableView:self.tableView
                                                   didSelectRowBlock:^(UITableView *tableView, NSIndexPath *indexPath)
    {
        strongify(self, weak_self);

        id entity = [controller objectAtIndexPath:indexPath];

        // like self.question.some_property = entity;
        [self.question setValue:entity forKey:[self.entityClass propertizeEntityName]];

        // force to put or remove checkmark at or from the selected cells
        [tableView reloadRowsAtIndexPaths:tableView.indexPathsForVisibleRows withRowAnimation:UITableViewRowAnimationFade];
    }];

    [self.tableView registerClass:[EntryCell class] forCellReuseIdentifier:[self entityCellID]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden = NO;
}

- (void)addEntity
{
    id entity = [self.entityClass createInContext:self.localContext];
    self.editingEntityID = [entity objectID];
}

- (NSManagedObjectContext *)localContext
{
    if (nil == _localContext) {
        return self.question.managedObjectContext;
    }
    return _localContext;
}

- (NSString *)entityCellID
{
    return [NSString stringWithFormat:@"%@Cell", [self.entityClass demodulizedEntityName]];
}

- (void)saveContext
{
    [self.localContext MR_saveOnlySelfWithCompletion:nil];
}

- (void)discardContext
{
    // balance created entities
    for (NSManagedObject *object in self.localContext.insertedObjects) {
        // don't delete objects that weren't created in this controller
        if (object.class == self.entityClass)
            [self.localContext deleteObject:object];
    }
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
    self.editingEntityID = nil; // must be nullify before updating entity object
    self.editingIndexPath = nil;

    // save text from text field
    id entity = [self.dataSource.fetchedResultsController objectAtIndexPath:editingIndexPath];
    [entity setTitle:self.entityTitle];
    self.entityTitle = nil;

    // set newly created entity as selected
    [self.question setValue:entity forKey:[self.entityClass propertizeEntityName]];

    // force to put or remove checkmark at or from the selected cells
    [self.tableView reloadRowsAtIndexPaths:self.tableView.indexPathsForVisibleRows withRowAnimation:UITableViewRowAnimationFade];

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
    self.editingEntityID = nil;
    self.editingIndexPath = nil;

    // reset cancel and done buttons
    [self resetNavigationBarButtonItems];

    // delete unsaved changes
    [self discardContext];
}

- (void)textDidChange:(id)sender
{
    // cache title for entity
    self.entityTitle = [sender text];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self done:nil];
    return NO;
}

@end