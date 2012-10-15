//
//  SDetailViewController.h
//  UICollectionViewExample
//
//  Created by Mason Mei on 10/11/12.
//  Copyright (c) 2012 Mason Mei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
