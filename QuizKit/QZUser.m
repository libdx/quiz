//
//  QZUser.m
//  Quiz
//
//  Created by Alexander Ignatenko on 9/6/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "QZUser.h"
#import "QZQuestion.h"


@implementation QZUser

@dynamic remoteID;
@dynamic username;
@dynamic token;
@dynamic createdAt;
@dynamic updatedAt;
@dynamic questions;

@end

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation QZUser (QuizKit)

static NSString *QZCurrentUserRemoteIDKey = @"QZCurrentUserRemoteIDKey";

+ (QZUser *)currentUser
{
    NSNumber *remoteID = [[NSUserDefaults standardUserDefaults] objectForKey:QZCurrentUserRemoteIDKey];
    return [self MR_findFirstByAttribute:@"remoteID" withValue:remoteID];
}

+ (void)setCurrentUser:(QZUser *)user
{
    QZUser *currentUser = [self currentUser];
    if ((nil == currentUser) || (![currentUser.remoteID isEqualToNumber:user.remoteID])) {
        [currentUser MR_deleteEntity];
        [currentUser.managedObjectContext MR_saveOnlySelfWithCompletion:^(BOOL success, NSError *error) {
            DDLogError(@"Error: %@ %@ %@", THIS_FILE, THIS_METHOD, error);
        }];
        [[NSUserDefaults standardUserDefaults] setObject:user.remoteID forKey:QZCurrentUserRemoteIDKey];
    }
}

@end
