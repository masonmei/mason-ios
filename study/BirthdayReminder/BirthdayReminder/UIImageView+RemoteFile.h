//
//  UIImageView+RemoteFile.h
//  BirthdayReminder
//
//  Created by Mason Mei on 4/2/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (RemoteFile)
-(void)setImageWithRemoteFileURL: (NSString *)urlString placeHolderImage:(UIImage *)placeHolderImage;
@end
