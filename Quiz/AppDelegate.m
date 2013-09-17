//
//  AppDelegate.m
//  Quiz
//
//  Created by Alexander Ignatenko on 9/4/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import <DDFileLogger.h>
#import <DDTTYLogger.h>
#import <DDASLLogger.h>

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "QuestionListViewController.h"

@interface AppDelegate ()
@property (strong, nonatomic) LoginViewController *loginController;
@end

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    [[AFHTTPRequestOperationLogger sharedLogger] startLogging];
    [MagicalRecord setupCoreDataStack];
    
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    [DDLog addLogger:fileLogger];
//    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    QuestionListViewController *questionListViewController = [[QuestionListViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:questionListViewController];
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    if (nil == [QZUser currentUser]) {
        self.loginController = [[LoginViewController alloc] init];
        [self.window.rootViewController presentViewController:self.loginController animated:NO completion:nil];
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)viewControllerDidSignInUser:(UIViewController *)viewController
{
    QZUser *user = [QZUser currentUser];
    DDLogVerbose(@"Username is: %@", user.username);
    [self.loginController dismissViewControllerAnimated:YES completion:nil];
}

@end
