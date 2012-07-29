//
//  MapViewController.h
//  PutAndTake
//
//  Created by Alexandru Savu on 7/12/12Week28.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MAPKit/MapKit.h>

@class MapViewController;

@protocol MapViewDelegate

-(NSInteger) buttonTag:(MapViewController *) sender;

@end

@interface MapViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate>{
    
    MKMapView *mapView;
    CLLocationManager *locationManager;
}

@property (nonatomic,strong) MKMapView *mapView;
@property (nonatomic,strong) NSArray *sharedLocations;
@property (nonatomic, weak) id <MapViewDelegate> delegate;
@property (nonatomic,strong) NSArray *currentZone;
@property (nonatomic) NSInteger currentZoneIndex;


- (void)getLocations;
- (void)lakesPositions;
- (void)chooseLocation;
- (void)zoomToFitMapAnnotations;

@end
