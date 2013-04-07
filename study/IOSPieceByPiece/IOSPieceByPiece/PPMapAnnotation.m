//
//  PPMapAnnotation.m
//  IOSPieceByPiece
//
//  Created by Mason Mei on 3/10/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import "PPMapAnnotation.h"

@implementation PPMapAnnotation

@synthesize coordinate = _coordinate, title = _title;

-(id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *) t {
    self = [super init];
    if(self){
        _coordinate = c;
        _title = t;
    }
    return self;
}

-(NSString *)title{
    return (_title == nil )? @"Mason is here!": _title;
}

@end
