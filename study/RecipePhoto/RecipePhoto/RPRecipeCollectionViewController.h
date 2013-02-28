//
//  RPRecipeCollectionViewController.h
//  RecipePhoto
//
//  Created by Mason Mei on 2/22/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RPRecipeCollectionHeaderView.h"

@interface RPRecipeCollectionViewController : UICollectionViewController <UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *shareButton;

- (IBAction)shareButtonTouched:(id)sender;

@end
