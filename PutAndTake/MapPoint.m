//
//  MapPoint.m
//  PutAndTake
//
//  Created by Alexandru Savu on 7/15/12Week29.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapPoint.h"

@implementation MapPoint

@synthesize coordinate = _coordinate;
@synthesize title = _title;

-(id) initWithCoordinate:(CLLocationCoordinate2D) coord title:(NSString *)t{
    
    self = [super init];
    if (self) {
        [self setCoordinate:coord];
        [self setTitle:t];
    }
    return self;
}

@end
