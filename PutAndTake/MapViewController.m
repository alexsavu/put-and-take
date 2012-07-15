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

-(void)viewWillAppear:(BOOL)animated 
{   
    mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:mapView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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

@end
