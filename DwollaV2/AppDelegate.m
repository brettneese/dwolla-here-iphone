//
//  AppDelegate.m
//  DwollaV2
//
//  Created by Nick Schulze on 2/14/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import "AppDelegate.h"
#import "Constants.h"
#import "ViewController.h"
#import <GeotriggerSDK/GeotriggerSDK.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [TestFlight takeOff:@"e1e62003-e644-4c6d-95f2-0384c8a8eb57"];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[ViewController alloc] initWithNibName:@"ViewController_iPhone" bundle:nil];
    } else {
        self.viewController = [[ViewController alloc] initWithNibName:@"ViewController_iPad" bundle:nil];
    }
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    [Parse setApplicationId:@"AhZlRy4PzHAMNmQZcnxzLBR5F4bAkRIZyxaHdTWS"
                  clientKey:@"kudOo9Qp8aTY6xEy9PAIPS6KNwEx0r8AV8caUPfP"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];

//    [AGSGTGeotriggerManager setupWithClientId:kClientId
//                              trackingProfile:kAGSGTTrackingProfileAdaptive
//               registerForRemoteNotifications:UIRemoteNotificationTypeAlert
//                                   completion:^(NSError *error) {
//                                       if (error == nil) {
//                                           NSLog(@"read to go!");
//
//                                       } else {
//                                           NSLog(@"No - Error!");
//                                       }
//                                   }];
//
//    [[AGSGTGeotriggerManager sharedManager] setLogLevel:AGSGTLogLevelDebug enableConsoleLogs:YES enableFileLogs:NO];

    return YES;
}

- (void)didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
}


- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {

    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
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

@end
