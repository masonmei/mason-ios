//
//  LMViewController.m
//  MyLocationMap
//
//  Created by masonmei on 12/5/12.
//  Copyright (c) 2012 personal.org. All rights reserved.
//

#import "LMViewController.h"

@interface LMViewController ()

@end

@implementation LMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.mapView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc]init];
    point.coordinate = userLocation.coordinate;
    point.title = @"Where am I ?";
    point.subtitle = @"I am here!!";
    
    [self.mapView addAnnotation:point];
}

@end
