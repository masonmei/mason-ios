//
//  ShapeView.h
//  SimonSays
//
//  Created by Mason Mei on 9/16/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import <UIKit/UIKit.h>
#define TRIANGLE 0
#define SQUARE 1
#define CIRCLE 2
#define PENTAGON 3

@interface ShapeView : UIView{
    int shape;
}
@property int shape;

-(id)initWithFrame:(CGRect)frame shape: (int)theShape;

@end
