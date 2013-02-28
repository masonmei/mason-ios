//
//  RPRecipeViewController.h
//  RecipePhoto
//
//  Created by Mason Mei on 2/23/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RPRecipeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *recipeImageView;
@property (weak, nonatomic) NSString *recipeImageName;

- (IBAction)close:(id)sender;
@end
