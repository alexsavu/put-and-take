//
//  ServerData.m
//  PutAndTake
//
//  Created by Alexandru Savu on 7/9/12Week28.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ServerData.h"
#import <RestKit/RKJSONParserJSONKit.h>


@implementation ServerData

static ServerData *singleton = nil;

+(ServerData* ) sharedInstance{
    if(singleton == nil){
        singleton = [[ServerData alloc] init];
    }
    return singleton;
}

- (void)sendRequests {
    // Perform a simple HTTP GET and call me back with the results
    [[RKClient sharedClient] get:@"/" delegate:self];
}


#pragma mark - Delegate

- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response
{
    if ([response isOK]) {
        // Success! Let's take a look at the data
        RKJSONParserJSONKit *thing = [RKJSONParserJSONKit new];
        locations = [thing objectFromString:[response bodyAsString] error:nil];
        
//        NSLog(@"Retrieved response: %@", [response bodyAsString]);
        NSLog(@"Locations : %@", locations );
    }
}

-(void)request:(RKRequest*)requestdidFailLoadWithError:(NSError*)error{
    NSLog(@"Ohno!Error:%@",[error localizedDescription]);
}

@end