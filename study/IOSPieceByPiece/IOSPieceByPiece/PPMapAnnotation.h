//
//  PPMapAnnotation.h
//  IOSPieceByPiece
//
//  Created by Mason Mei on 3/10/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface PPMapAnnotation : NSObject <MKAnnotation> {
    NSString *title;
    CLLocationCoordinate2D coordinate;
}

-(id)initWithCoordinate:(CLLocationCoordinate2D) coordinate title:(NSString *) title;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;

@end
