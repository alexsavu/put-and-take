//
//  MapViewController.h
//  PutAndTake
//
//  Created by Alexandru Savu on 7/12/12Week28.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController{
    
    MKMapView *mapView;
}

@property (nonatomic,strong) MKMapView *mapView;

@end
