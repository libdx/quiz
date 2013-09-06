//
//  QuizAuthClient.h
//  Quiz
//
//  Created by Alexander Ignatenko on 9/6/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import "AFHTTPClient.h"

@interface QuizAuthClient : AFHTTPClient

+ (instancetype)defaultClient;

- (void)authenticateUsername:(NSString *)username
                withPassword:(NSString *)password
                     success:(void (^)())success
                     failure:(void (^)(NSError *error))failure;

@end
