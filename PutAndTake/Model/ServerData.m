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

-(void)sendRequestsWithCompletionBlock:(void (^)(void))completion
                                failure:(void (^)(void))failure
{
    
    NSURL *url = [NSURL URLWithString:@"http://184.72.245.59:5000/areas"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        self.locations = (NSArray *) JSON;
        
        if (completion) {
            completion();
        }
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response,NSError *error, id JSON){
        if (failure) {
            failure();
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ups. There was an error"
                                                        message:[error localizedDescription]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }];
    [operation start];
}


-(NSArray *) returnLocations:(MapViewController *)sender
{
    return self.locations;
}

@end
