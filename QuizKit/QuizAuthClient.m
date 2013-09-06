//
//  QuizAuthClient.m
//  Quiz
//
//  Created by Alexander Ignatenko on 9/6/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "QuizAuthClient.h"

#define BASE_RAW_URL @"localhost"

#define call_block(block) do { {if (block != nil) block();} } while(0)
#define call_block_with(block, ...) do { {if (block != nil) block(__VA_ARGS__);} } while(0)

@implementation QuizAuthClient

+ (instancetype)defaultClient
{
    static QuizAuthClient *AuthClient;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        AuthClient = [[QuizAuthClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_RAW_URL]];
    });
    return AuthClient;
}

- (void)authenticateUsername:(NSString *)username
                withPassword:(NSString *)password
                     success:(void (^)())success
                     failure:(void (^)(NSError *error))failure
{
    if (![username isEqualToString:@"root"] && ![username isEqualToString:@"mock"]) {
        call_block_with(failure, [NSError errorWithDomain:@"Mock"
                                                     code:-1
                                                 userInfo:@{NSLocalizedDescriptionKey : @"There is no such username"}]);
        return;
    }
    // mocking Data
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        sleep(2); // mocking network activity
        QZUser *user = [QZUser MR_createInContext:localContext];
        user.username = username;
        user.remoteID = [username isEqualToString:@"root"] ? @42 : @911;
        [QZUser setCurrentUser:user];
    } completion:^(BOOL isSuccess, NSError *error) {
        if (isSuccess)
            call_block(success);
        else
            call_block_with(failure, error);
    }];
}

@end
