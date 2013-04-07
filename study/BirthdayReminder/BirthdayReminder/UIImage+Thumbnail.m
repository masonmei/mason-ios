//
//  UIImage+Thumbnail.m
//  BirthdayReminder
//
//  Created by Mason Mei on 3/29/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import "UIImage+Thumbnail.h"

@implementation UIImage (Thumbnail)

-(UIImage *)createThumbnailToFillSize:(CGSize)size{
    CGSize mainImageSize = self.size;
    
    UIImage *thumb;
    
    CGFloat widthScaler= size.width / mainImageSize.width;
    CGFloat heightScaler = size.height / mainImageSize.height;
    
    CGSize repositionedMainImageSize = mainImageSize;
    CGFloat scaleFactor;
    
    if(widthScaler > heightScaler){
        scaleFactor = widthScaler;
        repositionedMainImageSize.height = ceil(size.height / scaleFactor);
    } else {
        scaleFactor = heightScaler;
        repositionedMainImageSize.width = ceil(size.width / scaleFactor);
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGFloat xInc = ((repositionedMainImageSize.width - mainImageSize.width)/ 2.f) *scaleFactor;
    CGFloat yInc = ((repositionedMainImageSize.height - mainImageSize.height)/2.f) *scaleFactor;
    
    [self drawInRect:CGRectMake(xInc, yInc, mainImageSize.width * scaleFactor, mainImageSize.height * scaleFactor)];
    thumb = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return thumb;
}

@end
