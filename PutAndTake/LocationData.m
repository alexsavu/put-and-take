//
//  LocationData.m
//  PutAndTake
//
//  Created by Alexandru Savu on 7/10/12Week28.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LocationData.h"

@implementation LocationData
@synthesize locationManager = _locationManager;
@synthesize currentLocation = _currentLocation;

-(id) init{
    self = [super init];
    if (self != nil) {
        _locationManager = [[CLLocationManager alloc] init];
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    _currentLocation = newLocation;
    
    if (newLocation.horizontalAccuracy <= 100.0f) {
        [_locationManager stopUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    if(error.code == kCLErrorDenied) {
        [_locationManager stopUpdatingLocation];
    } else if(error.code == kCLErrorLocationUnknown) {
        // retry
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error retrieving location"
                                                        message:[error description]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

@end
