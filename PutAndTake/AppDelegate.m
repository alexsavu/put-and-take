//
//  AppDelegate.m
//  PutAndTake
//
//  Created by Alexandru Savu on 6/11/12Week24.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import <RestKit/RestKit.h>
#import "ViewController.h"
#import "MapViewController.h"
#import "GANTracker.h"
#import <Crashlytics/Crashlytics.h>

static const NSInteger kGANDispatchPeriodSec = 10;

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize mapViewController = _mapViewController;
@synthesize navigationController = _navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //Crashlytics
    [Crashlytics startWithAPIKey:@"64fa61fc5170cbc0c21ce61778c46c3b217dedf8"];
    
    //Google analytics
    [[GANTracker sharedTracker] startTrackerWithAccountID:@"UA-34223732-1"
                                           dispatchPeriod:10
                                                 delegate:nil];
    
    //Instatiating the app's window
    
    CGRect windowFrame = [[UIScreen mainScreen] bounds];
    self.window = [[UIWindow alloc] initWithFrame:windowFrame];
    self.viewController = [[ViewController alloc] init];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    [self.window setRootViewController:self.navigationController];
    [self.window addSubview: self.viewController.view];
    [self.navigationController setNavigationBarHidden:YES];
    self.viewController.view.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1];
    
    [self.window makeKeyAndVisible];
    
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

@end
