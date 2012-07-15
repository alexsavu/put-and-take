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

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize mapViewController = _mapViewController;
@synthesize mapView = _mapView;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    // Override point for customization after application launch.
//    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
//    self.window.rootViewController = self.viewController;
//    [self.window makeKeyAndVisible];
    
    //Instatiating the app's window
    
    CGRect windowFrame = [[UIScreen mainScreen] bounds];
    self.window = [[UIWindow alloc] initWithFrame:windowFrame];
    self.viewController = [[ViewController alloc] initWithNibName:nil bundle:nil];
    [self.window addSubview: self.viewController.view];
    
    
//    //Instatiating the app's window
//    
//    CGRect windowFrame = [[UIScreen mainScreen] bounds];
//    self.window = [[UIWindow alloc] initWithFrame:windowFrame];
//    self.mapViewController = [[MapViewController alloc] initWithNibName:nil bundle:nil];
//    [self.window addSubview: self.mapViewController.view];
    
    self.mapView = [[MKMapView alloc]initWithFrame:windowFrame];
    [self.window addSubview:self.mapView];
    
    
    //Initializing RK with the base URL
    
    [RKClient clientWithBaseURLString:@"http://localhost:1337"];
    
    //Core location manager
    locationManager = [[CLLocationManager alloc] init];
    
    //Delegate for location
    [locationManager setDelegate:self];
    
    //Asking for all results from the location manager
    [locationManager setDistanceFilter:kCLDistanceFilterNone];
    
    //Make it as acurate as possible
    [locationManager setDistanceFilter:kCLLocationAccuracyBest];
    
    //Tell the manager to start looking for its location
//    [locationManager startUpdatingLocation];
    
    [self.mapView setShowsUserLocation:YES];
    
    
    [self.window makeKeyAndVisible];

    
    
    return YES;
}

#pragma mark MapViewDelegate protocol methods

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
}

#pragma mark location delegate method

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    NSLog(@"%@", newLocation);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    NSLog(@"Could not find location %@", error);
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
