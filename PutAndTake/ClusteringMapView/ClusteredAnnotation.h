//
//  ClusteredAnnotation.h
//  MapPinClustering
//
//  Created by Kevin Kazmierczak on 4/5/12.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface ClusteredAnnotation : NSObject <MKAnnotation>{
    CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
    NSString *price;
    NSString *phone;
    NSString *address;
    CLLocationCoordinate2D clusterCoordinate;
    CLLocationCoordinate2D actualCoordinate;
    
    NSMutableArray *childAnnotations;
}

@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;
@property (nonatomic, readwrite) CLLocationCoordinate2D clusterCoordinate;
@property (nonatomic, readwrite) CLLocationCoordinate2D actualCoordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, retain) NSMutableArray *childAnnotations;

- (id)initWithCoordinate:(CLLocationCoordinate2D) aCoordinate andTitle:(NSString *)aTitle
                andPrice:(NSString *)aPrice andPhone:(NSString *)aPhone andAddress:(NSString *)anAddress;
- (void) addChild:(ClusteredAnnotation*) childAnnotation;
- (void) removeAllChildren;
- (NSString *)getKey;

@end

