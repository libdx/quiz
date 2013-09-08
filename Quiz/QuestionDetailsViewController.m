//
//  QuestionDetailsViewController.m
//  Quiz
//
//  Created by Alexander Ignatenko on 9/7/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "QuestionDetailsViewController.h"
#import "UIViewController+Editing.h"

@interface QuestionDetailsViewController ()

@property (strong, nonatomic) QZQuestion *question;

@property (strong, nonatomic) NSManagedObjectContext *localContext;

@property (nonatomic, getter=isShowingModal) BOOL showingModal;

@property (copy, nonatomic) void (^willDismissViewController)(UIViewController *viewController);

@property (copy, nonatomic) void (^didDismissViewController)(UIViewController *viewController);

@property (strong, nonatomic) QEntryElement *titleElement;

@property (strong, nonatomic) QEntryElement *bodyElement;

@property (strong, nonatomic) NSMutableArray *bindElements;

@end

@implementation QuestionDetailsViewController

@synthesize showingModal = _showingModal;
@synthesize willDismissViewController = _willDismissViewController;
@synthesize didDismissViewController = _didDismissViewController;

- (QRootElement *)buildRootWithElements
{
    QRootElement *rootElement = [[QRootElement alloc] init];
    rootElement.grouped = YES;
    QSection *textSection = [[QSection alloc] init];
    self.titleElement = [[QEntryElement alloc]
                                   initWithTitle:nil Value:nil
                                   Placeholder:NSLocalizedString(@"Title", @"Question Title")];
    self.titleElement.bind = @"textValue:title";
    self.titleElement.appearance.entryAlignment = NSTextAlignmentCenter;
    self.bodyElement = [[QEntryElement alloc] initWithTitle:nil
                                                      Value:self.question.body
                                                Placeholder:NSLocalizedString(@"Overview", @"Question Overview")];
    self.bodyElement.bind = @"textValue:body";
    [textSection addElement:self.titleElement];
    [textSection addElement:self.bodyElement];

    [self.bindElements addObject:self.titleElement];
    [self.bindElements addObject:self.bodyElement];

    [rootElement addSection:textSection];

    return rootElement;
}

- (id)init
{
    return [super initWithRoot:[self buildRootWithElements]];
}

- (id)initWithQuestionRemoteID:(NSNumber *)questionRemoteID
{
    self = [self init];
    if (self) {
        _questionRemoteID = questionRemoteID;
    }
    return self;
}

- (QZQuestion *)question
{
    if (nil == _question) {
        _question = [QZQuestion MR_findFirstByAttribute:@"remoteID"
                                              withValue:_questionRemoteID
                                              inContext:self.localContext];
        if (nil == _question)
            _question = [QZQuestion MR_createInContext:self.localContext];
    }
    return _question;
}

- (NSManagedObjectContext *)localContext
{
    _localContext = [self setupLocalContextWithInstanceVariable:_localContext];
    _localContext.MR_workingName = @"QuestionDetails";
    return _localContext;
}

- (NSMutableArray *)bindElements
{
    if (nil == _bindElements)
        _bindElements = [NSMutableArray array];
    return _bindElements;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupDoneAndCancelButtons];
}

- (void)discardUnsavedChanges
{
    [self.localContext refreshObject:self.question mergeChanges:NO];
}

- (void)updateUI
{
    [self.bindElements.copy makeObjectsPerformSelector:@selector(bindToObject:) withObject:self.question];
}

- (void)updateModel
{
    [self.bindElements.copy makeObjectsPerformSelector:@selector(fetchValueUsingBindingsIntoObject:)
                                            withObject:self.question];
}

@end
