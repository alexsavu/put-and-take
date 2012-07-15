//
//  ServerData.h
//  PutAndTake
//
//  Created by Alexandru Savu on 7/9/12Week28.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ServerData : NSObject<RKRequestDelegate>{

    NSArray *locations;
}

+(ServerData* ) sharedInstance;

- (void)sendRequests;

@end
