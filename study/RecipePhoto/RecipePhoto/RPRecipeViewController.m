//
//  RPRecipeViewController.m
//  RecipePhoto
//
//  Created by Mason Mei on 2/23/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import "RPRecipeViewController.h"

@interface RPRecipeViewController ()

@end

@implementation RPRecipeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.recipeImageView.image = [UIImage imageNamed:self.recipeImageName];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
