//
//  ShapeView.m
//  SimonSays
//
//  Created by Mason Mei on 9/16/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import "ShapeView.h"

@implementation ShapeView
@synthesize shape;

- (id)initWithFrame:(CGRect)frame shape:(int)theShape {
    self = [super initWithFrame:frame];
    if (self) {
        self.shape = theShape;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    UIBezierPath* path;
    UIColor* fillColor;
    // Draw the desired shape
    switch (shape) {
        case TRIANGLE:
            path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(self.bounds.size.width/2, 0)];
            [path addLineToPoint:CGPointMake(0,self.bounds.size.height)];
            [path addLineToPoint:CGPointMake(self.bounds.size.width,
                                             self.bounds.size.height)];
            [path closePath];
            fillColor = [UIColor blueColor];
            break;
        case SQUARE:
            path = [UIBezierPath bezierPathWithRect:self.bounds];
            fillColor = [UIColor yellowColor];
            break;
        case CIRCLE:
            path = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
            fillColor = [UIColor greenColor];
            break;
        case PENTAGON:
            path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(self.bounds.size.width/2, 0)];
            [path addLineToPoint:CGPointMake(0,self.bounds.size.height/3)];
            [path addLineToPoint:CGPointMake(self.bounds.size.width/5
                                             ,self.bounds.size.height)];
            [path addLineToPoint:CGPointMake(4*self.bounds.size.width/5,
                                             self.bounds.size.height)];
            [path addLineToPoint:CGPointMake(self.bounds.size.width
                                             ,self.bounds.size.height/3)];
            [path closePath];
            fillColor = [UIColor redColor];
            break;
        default:
            path = [UIBezierPath bezierPathWithRect:self.bounds];
            fillColor = [UIColor yellowColor];
            break;
    }
    // Fill the path
    [fillColor setFill];
    [path fill];
}


@end
