//
//  TestView.m
//  GraphicsStart
//
//  Created by Mason Mei on 9/9/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import "TestView.h"

@implementation TestView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)drawRect:(CGRect)rect{
    CGRect aRectangle = CGRectMake(0.0, 0.0, 40.0, 40.0);
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:aRectangle];
    
    [path stroke];
    path = [UIBezierPath bezierPathWithOvalInRect:aRectangle];
    [path fill];
    
    UIBezierPath *startPath = [UIBezierPath bezierPath];
    [startPath moveToPoint:CGPointMake(40.0, 0.0)];
    [startPath addLineToPoint:CGPointMake(30.0, 30.0)];
    [startPath addLineToPoint:CGPointMake(0.0, 30.0)];
    [startPath addLineToPoint:CGPointMake(20.0, 50.0)];
    [startPath addLineToPoint:CGPointMake(10.0, 80.0)];
    [startPath addLineToPoint:CGPointMake(40.0, 60.0)];
    [startPath addLineToPoint:CGPointMake(70.0, 80.0)];
    [startPath addLineToPoint:CGPointMake(60.0, 50.0)];
    [startPath addLineToPoint:CGPointMake(80.0, 30.0)];
    [startPath addLineToPoint:CGPointMake(50.0, 30.0)];
    [startPath closePath];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 100, 100);
    UIColor *color = [UIColor yellowColor];
    [color setFill];
    [startPath fill];
    
    CGContextTranslateCTM(context, 100, 100);
    CGContextRotateCTM(context, 3.14/4);
    color = [UIColor greenColor];
    [color setFill];
    [startPath fill];
    [startPath stroke];
    
    CGContextRestoreGState(context);
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 50, 250);
    [startPath fill];
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 220, 0);
    CGContextSetShadow(context, CGSizeMake(10, 10), 5);
    color = [UIColor orangeColor];
    [color setFill];
    [startPath fill];
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 220, 320);
    CGGradientRef myGradient;
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGFloat component[8] = {1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 1.0};
    int num_locations = 2;
    CGFloat locations[2] = {0.0, 1.0};
    
    myGradient = CGGradientCreateWithColorComponents(colorSpaceRef, component, locations, num_locations);
    [startPath addClip];
    CGContextDrawLinearGradient(context, myGradient, CGPointMake(0, 0), CGPointMake(80, 0), 0);
    CGColorSpaceRelease(colorSpaceRef);
    CGGradientRelease(myGradient);
    CGContextRestoreGState(context);
}

@end
