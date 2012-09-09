//
//  BlockerView.m
//  Blocker
//
//  Created by Mason Mei on 9/9/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import "BlockerView.h"

@implementation BlockerView
@synthesize color;

- (id)initWithFrame:(CGRect)frame color:(int)inputColor
{
    self = [super initWithFrame:frame];
    if (self) {
        self.color = inputColor;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    float viewWidth, viewHeight;
    viewWidth = self.bounds.size.width;
    viewHeight = self.bounds.size.height;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect blockRect = CGRectMake(0, 0, viewWidth, viewHeight);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:blockRect];
    path.lineWidth = 2.0;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef mGradient;
    int num_locations = 2;
    CGFloat locations[2] = {0.0, 1.0};
    CGFloat component[8] = {0.0, 0.0, 0.0, 1.0,1.0, 1.0, 1.0, 1.0};
    
    switch (self.color) {
        case RED_COLOR:
            component[0] = 1.0;
            break;
        case GREEN_COLOR:
            component[1] = 1.0;
            break;
        case BLUE_COLOR:
            component[2] = 1.0;
            break;
        default:
            break;
    }
    
    mGradient = CGGradientCreateWithColorComponents(colorSpace, component, locations, num_locations);
    
    CGContextDrawLinearGradient(context, mGradient, CGPointMake(0, 0), CGPointMake(viewWidth, 0), 0);
    
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(mGradient);
    
    [path stroke];
}

@end
