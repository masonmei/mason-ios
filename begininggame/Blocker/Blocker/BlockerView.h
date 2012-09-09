//
//  BlockerView.h
//  Blocker
//
//  Created by Mason Mei on 9/9/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RED_COLOR 0
#define GREEN_COLOR 1
#define BLUE_COLOR 2

@interface BlockerView : UIView{
    int color;
}

@property int color;

-(id) initWithFrame:(CGRect)frame color:(int) inputColor;

@end
