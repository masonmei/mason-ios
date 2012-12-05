//
//  FSViewController.m
//  FlickrSearch
//
//  Created by masonmei on 12/5/12.
//  Copyright (c) 2012 personal.org. All rights reserved.
//

#import "FSViewController.h"
#import "Flickr.h"
#import "FlickrPhoto.h"

@interface FSViewController ()<UITextFieldDelegate>
@property (nonatomic, weak) IBOutlet UIToolbar *toolbar;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *sharedButton;
@property (nonatomic, weak) IBOutlet UITextField *textField;

@property (nonatomic, strong) NSMutableDictionary *searchResult;
@property (nonatomic, strong) NSMutableArray *searchs;
@property (nonatomic, strong) Flickr *flickr;


-(IBAction)shareButtonTapped:(id)sender;

@end

@implementation FSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_cork.png"]];
    UIImage *nabBarImage = [[UIImage imageNamed:@"navbar.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(27, 27, 27, 27)];
    [self.toolbar setBackgroundImage:nabBarImage forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    
    UIImage *shareButtonImage = [[UIImage imageNamed:@"button.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    [self.sharedButton setBackgroundImage:shareButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    UIImage *textFieldImage = [[UIImage imageNamed:@"search_field.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [self.textField setBackground:textFieldImage];
    
    self.searchResult = [@[] mutableCopy];
    self.searchs = [@{} mutableCopy];
    self.flickr = [[Flickr alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)shareButtonTapped:(id)sender{
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.flickr searchFlickrForTerm:textField.text completionBlock:^(NSString *searchTerm, NSArray *results, NSError *error){
        if(results && [results count] > 0){
            if(![self.searchs containsObject:searchTerm]){
                NSLog(@"Found %d photos matching %@", [results count], searchTerm);
                [self.searchs insertObject:searchTerm atIndex:0];
                self.searchResult[searchTerm] = results;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                //TODO:
            });
        }else{
            NSLog(@"Error searching Flickr:%@", error.localizedDescription);
        }
    }];
    [textField resignFirstResponder];
    return YES;
}

@end
