//
//  LMViewController.h
//  MyLocationMap
//
//  Created by masonmei on 12/5/12.
//  Copyright (c) 2012 personal.org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface LMViewController : UIViewController <MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end
