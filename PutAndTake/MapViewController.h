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

@interface MapViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate>{
    
    MKMapView *mapView;
    CLLocationManager *locationManager;
}

@property (nonatomic,strong) MKMapView *mapView;

@end
