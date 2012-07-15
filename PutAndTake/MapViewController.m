//
//  MapViewController.m
//  PutAndTake
//
//  Created by Alexandru Savu on 7/12/12Week28.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"

@implementation MapViewController

@synthesize mapView = _mapView;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.mapView];
    
    //Sets the map delegate to this object
    [self.mapView setDelegate:self];
    
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
    
    //Shows the blue annotation
    [self.mapView setShowsUserLocation:YES];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark MapViewDelegate protocol methods

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    CLLocationCoordinate2D coordinate = [userLocation coordinate];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 250, 250);
    [self.mapView setRegion:region animated:YES];
    
}

#pragma mark location delegate method

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    NSLog(@"!!!!!!!!!!!!!!!!! :%@", newLocation);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    NSLog(@"Could not find location %@", error);
}

@end
