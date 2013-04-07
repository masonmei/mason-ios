//
//  PPMapViewController.m
//  IOSPieceByPiece
//
//  Created by Mason Mei on 3/10/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import "PPMapViewController.h"
#import "PPMapAnnotation.h"

@interface PPMapViewController ()

@end

@implementation PPMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.mapView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    CLLocationCoordinate2D loc = [userLocation coordinate];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 2, 2);
    [self.mapView setRegion:region];
    PPMapAnnotation *mapAnnotation = [[PPMapAnnotation alloc] initWithCoordinate:loc title:@"MMEI"];
    [mapView removeAnnotations:[mapView annotations]];
    [mapView addAnnotation:mapAnnotation];
}

@end
