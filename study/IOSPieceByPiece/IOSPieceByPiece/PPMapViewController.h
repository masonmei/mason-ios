//
//  PPMapViewController.h
//  IOSPieceByPiece
//
//  Created by Mason Mei on 3/10/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface PPMapViewController : UIViewController <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
