//
//  ServerData.m
//  PutAndTake
//
//  Created by Alexandru Savu on 7/9/12Week28.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ServerData.h"
#import "MapViewController.h"
#import "JSONKit.h"


@implementation ServerData

@synthesize locations = _locations;

static ServerData *singleton = nil;

+(ServerData* ) sharedInstance{
    if(singleton == nil){
        singleton = [[ServerData alloc] init];
    }
    return singleton;
}



-(NSArray *)sendRequests {
// Perform a simple HTTP GET and call me back with the results
//    [[RKClient sharedClient] get:@"/" delegate:self];
    
    NSURL *url = [NSURL URLWithString:@"http://184.72.245.59:5000/areas"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
//        NSLog(@"App.net Global Stream: %@", JSON);
        self.locations = (NSArray *) JSON;
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response,NSError *error, id JSON){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Errorrrrr"
                                                        message:[error localizedDescription]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }];
    [operation start];
    return self.locations;
}


-(NSArray *) returnLocations:(MapViewController *)sender
{
    return self.locations;
}

@end
