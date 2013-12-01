//
//  AppDelegate.h
//  DwollaV2
//
//  Created by Nick Schulze on 2/14/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "CommandCenter.h"



@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    CommandCenter* command;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@end
