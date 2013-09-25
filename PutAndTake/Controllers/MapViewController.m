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
#import "DetailsViewController.h"
#import "UIViewController+KNSemiModal.h"
#import "ClusteredAnnotation.h"
#import "ClusteringMapView.h"
#import "TestDragView.h"
#import <MBHUDView.h>

@interface MapViewController()

@property (nonatomic, strong) TestDragView *testDrag;

@end

@implementation MapViewController

@synthesize theMapView = _theMapView;
@synthesize sharedLocations = _sharedLocations;
@synthesize currentZone = _currentZone;
@synthesize currentZoneIndex = _currentZoneIndex;
@synthesize arrayOfLocations = _arrayOfLocations;
@synthesize annotation = _annotation;

- (void) viewDidAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
    [MBHUDView hudWithBody:@"Loading places" type:MBAlertViewHUDTypeActivityIndicator hidesAfter:0.f show:YES];
    ServerData *data = [[ServerData alloc] init];
    [data sendRequestsWithCompletionBlock:^{
        [MBHUDView dismissCurrentHUD];
        self.sharedLocations = data.locations;
        [self lakesPositions];
    } failure:^{
        [MBHUDView dismissCurrentHUD];
    }];
    [self addBackButton];
}

- (void)addBackButton
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(5, 5, 50, 50);
    [backButton setBackgroundImage:[UIImage imageNamed:@"big_arrow"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(moveBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.arrayOfLocations = [[NSMutableArray alloc] init];
    
    self.theMapView = [[ClusteringMapView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.theMapView];
    
    //Sets the map delegate to this object
    [self.theMapView setDelegate:self];
    
//    //Core location manager
//    locationManager = [[CLLocationManager alloc] init];
//    
//    //Delegate for location
//    [locationManager setDelegate:self];
//    
//    //Asking for all results from the location manager
//    [locationManager setDistanceFilter:kCLDistanceFilterNone];
//    
//    //Make it as acurate as possible
//    [locationManager setDistanceFilter:kCLLocationAccuracyBest];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
}

-(void)moveBack{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)chooseLocation{
    if (self.sharedLocations != nil) {
        self.currentZone = [[NSMutableArray alloc] init];
        switch (self.buttonPressed) {
            case 0:
                [self.currentZone addObject:[[self.sharedLocations objectAtIndex:0] valueForKey:@"locations"]];
                break;
            case 1:
                [self.currentZone addObject:[[self.sharedLocations objectAtIndex:1] valueForKey:@"locations"]];
                break;
            case 2:
                [self.currentZone addObject:[[self.sharedLocations objectAtIndex:2] valueForKey:@"locations"]];
                break;
            case 3:
                [self.currentZone addObject:[[self.sharedLocations objectAtIndex:3] valueForKey:@"locations"]];
                break;
            case 4:
                [self.currentZone addObject:[[self.sharedLocations objectAtIndex:4] valueForKey:@"locations"]];
                break;
            case 5:
                [self.currentZone addObject:[[self.sharedLocations objectAtIndex:5] valueForKey:@"locations"]];
                break;
            case 6:
                [self.currentZone addObject:[[self.sharedLocations objectAtIndex:6] valueForKey:@"locations"]];
                break;
            default:
                break;
        }
    }
}

-(void)lakesPositions {
    [self chooseLocation];
    
    for (NSDictionary* row in [self.currentZone objectAtIndex:0]) {
        NSNumber *latitude = [row valueForKey:@"latitude"];
        NSNumber *longitude = [row valueForKey:@"longitude"];
        NSString *name = [row valueForKey:@"name"];
        NSString *price = [row valueForKey:@"price"];
        NSString *phone = [row valueForKey:@"phone"];
        NSString *address = [row valueForKey:@"address"];
        
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = latitude.doubleValue;
        coordinate.longitude = longitude.doubleValue;
        self.annotation = [[ClusteredAnnotation alloc] initWithCoordinate:coordinate andTitle:name andPrice:price andPhone:phone andAddress:address];
        self.annotation.title = name;
        [self.arrayOfLocations addObject:self.annotation];

    }

    // Center out map on our locations
    if ([self.arrayOfLocations count] > 0) {
        [self.theMapView centerMapOnAnnotationSet:self.arrayOfLocations];
    }
    // Add our annotations to the map
    [self.theMapView addAnnotations:self.arrayOfLocations];
    [MBHUDView dismissCurrentHUD];
}


- (void)zoomToFitMapAnnotations {
    if ([self.theMapView.annotations count] == 0) return;
    
    int i = 0;
    MKMapPoint points[[self.theMapView.annotations count]];
    
    //build array of annotation points
    for (id<MKAnnotation> annotation in [self.theMapView annotations])
        points[i++] = MKMapPointForCoordinate(annotation.coordinate);
    
    MKPolygon *poly = [MKPolygon polygonWithPoints:points count:i];
    
    [self.theMapView setRegion:MKCoordinateRegionForMapRect([poly boundingMapRect]) animated:YES];
}

#pragma mark MapViewDelegate protocol methods

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    static NSString *identifier = @"MyLocation";
    
    if ([annotation isKindOfClass:[ClusteredAnnotation class]]) {
        
        MKAnnotationView *annotationView = (MKAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        } else {
            annotationView.annotation = annotation;
        }
        
        UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        annotationView.rightCalloutAccessoryView = infoButton;
        
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        annotationView.image=[UIImage imageNamed:@"map_pointer.png"];
        return annotationView;
    }
    
    return nil;    
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view
        calloutAccessoryControlTapped:(UIControl *)control
{
    if ([((UIButton *)control)buttonType] == UIButtonTypeDetailDisclosure) {
        DetailsViewController *detailsViewController =[[DetailsViewController alloc] initWithSize:0 Y:0 Width:320 Height:340];
        [self presentSemiViewController:detailsViewController];
        detailsViewController.price = [(ClusteredAnnotation*)[view annotation] price];
        detailsViewController.phone = [(ClusteredAnnotation*)[view annotation] phone];
        detailsViewController.address = [(ClusteredAnnotation*)[view annotation] address];
    }
}

@end
