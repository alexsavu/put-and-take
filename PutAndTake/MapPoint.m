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

-(id) initWithCoordinate:(CLLocationCoordinate2D) coord title:(NSString *)t
{
    
    self = [super init];
    if (self) {
        _coordinate.latitude = coord.latitude;
        _coordinate.longitude = coord.longitude;
        self.title = t;
    }
    return self;
}

//- (NSString *)title {
//    if ([self.title isKindOfClass:[NSNull class]])
//        return @"Unknown charge";
//    else
//        return self.title;
//}

@end
