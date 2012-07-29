//
//  MapViewController.m
//  PutAndTake
//
//  Created by Alexandru Savu on 7/12/12Week28.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "ServerData.h"
#import "MapPoint.h"
#import "ViewController.h"


@implementation MapViewController

@synthesize mapView = _mapView;
@synthesize sharedLocations = _sharedLocations;
@synthesize delegate = _delegate;
@synthesize currentZone = _currentZone;
@synthesize currentZoneIndex = _currentZoneIndex;

- (void) viewDidAppear:(BOOL)animated
{
    ServerData *data = [ServerData sharedInstance];
    [data sendRequests];
    
    [self performSelector:@selector(getLocations) withObject:self afterDelay:0.3];
    
    [self performSelector:@selector(lakesPositions) withObject:self afterDelay:0.4];
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
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
//    [self.mapView setShowsUserLocation:YES];


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

-(void)chooseLocation
{
    switch ([ViewController pressedTag]) {
        case 20:
            self.currentZone = [self.sharedLocations valueForKey:@"Nordjelland"];
            self.currentZoneIndex = 0;
            break;
            
        default:
            break;
    }
}


-(void) getLocations
{
    ServerData *data = [ServerData sharedInstance];
    self.sharedLocations = data.locations;
    
//    NSLog(@"Latitude %@", [[[[self.sharedLocations valueForKey:@"awesomeLocations"] objectAtIndex:0] objectAtIndex:0] valueForKey:@"latitude"]);
    
//    NSLog(@"!!!!!!!!!!!!!!!!!! %@", self.sharedLocations);
//    NSLog(@"The button type is : %d", [ViewController pressedTag]);

//    NSLog(@"Location from the viewcontroller: %@",[[self.sharedLocations valueForKey:@"awesomeLocations"] valueForKey:@"latitude"]);
    
}


- (void)lakesPositions {
    
    for (id<MKAnnotation> annotation in self.mapView.annotations) {
        [self.mapView removeAnnotation:annotation];
    }
    
    [self chooseLocation];
    
    NSLog(@"The things : %@", [self.currentZone objectAtIndex:self.currentZoneIndex]);
    
    for (NSArray* row in [self.currentZone objectAtIndex:self.currentZoneIndex]) {
        
        NSNumber * latitude = [row valueForKey:@"latitude"];
        NSNumber * longitude = [row valueForKey:@"longitude"];
        NSString * name = [row valueForKey:@"name"];
        
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = latitude.doubleValue;
        coordinate.longitude = longitude.doubleValue;
        MapPoint *annotation = [[MapPoint alloc] initWithCoordinate:coordinate title:name] ;
        [self.mapView addAnnotation:annotation];
        [self zoomToFitMapAnnotations];
        
    }
}


- (void)zoomToFitMapAnnotations {
    
    if ([self.mapView.annotations count] == 0) return;
    
    int i = 0;
    MKMapPoint points[[self.mapView.annotations count]];
    
    //build array of annotation points
    for (id<MKAnnotation> annotation in [self.mapView annotations])
        points[i++] = MKMapPointForCoordinate(annotation.coordinate);
    
    MKPolygon *poly = [MKPolygon polygonWithPoints:points count:i];
    
    [self.mapView setRegion:MKCoordinateRegionForMapRect([poly boundingMapRect]) animated:YES];
}

#pragma mark MapViewDelegate protocol methods

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    static NSString *identifier = @"MyLocation";
    if ([annotation isKindOfClass:[MapPoint class]]) {
        
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        } else {
            annotationView.annotation = annotation;
        }
        
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        annotationView.image=[UIImage imageNamed:@"map_pointer.png"];        
        return annotationView;
    }
    
    return nil;    
}


//- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
//    
//    CLLocationCoordinate2D coordinate = [userLocation coordinate];
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 250, 250);
//    [self.mapView setRegion:region animated:YES];
//    
//}

#pragma mark location delegate method

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    NSLog(@"!!!!!!!!!!!!!!!!! :%@", newLocation);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    NSLog(@"Could not find location %@", error);
}

@end
