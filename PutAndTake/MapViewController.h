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

@class ClusteringMapView;
@class ClusteredAnnotation;

@interface MapViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
}

@property (nonatomic, strong) ClusteredAnnotation *annotation;
@property (nonatomic,strong) ClusteringMapView *theMapView;
@property (nonatomic,strong) NSArray *sharedLocations;
@property (nonatomic,strong) NSMutableArray *currentZone;
@property (nonatomic) NSInteger currentZoneIndex;
@property (nonatomic, strong) NSMutableArray *arrayOfLocations;


- (void)getLocations;
- (void)lakesPositions;
- (void)chooseLocation;
- (void)zoomToFitMapAnnotations;
- (void)addBackButton;
- (void)moveBack;

@end
