//
//  BRStyleSheet.m
//  BirthdayReminder
//
//  Created by Mason Mei on 3/29/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import "BRStyleSheet.h"
#import <QuartzCore/QuartzCore.h>
#import "BRBlueButton.h"
#import "BRRedButton.h"

#define kFontLightOnDarkTextColour [UIColor colorWithRed:255.0/255 green:251.0/255 blue:218.0/255 alpha:1.0]
#define kFontDarkOnLightTextColour [UIColor colorWithRed:1.0/255 green:1.0/255 blue:1.0/255 alpha:1.0]
#define kFontNavigationTextColour [UIColor colorWithRed:106.f/255.f green:62.f/255.f blue:39.f/255.f alpha:1.f]
#define kFontNavigationDisabledTextColour [UIColor colorWithRed:106.f/255.f green:62.f/255.f blue:39.f/255.f alpha:0.6f]
#define kNavigationButtonBackgroundColour [UIColor colorWithRed:255.f/255.f green:245.f/255.f blue:225.f/255.f alpha:1.f]
#define kToolbarButtonBackgroundColour [UIColor colorWithRed:39.f/255.f green:17.f/255.f blue:5.f/255.f alpha:1.f]
#define kLargeButtonTextColour [UIColor whiteColor]
#define kFontNavigation [UIFont fontWithName:@"HelveticaNeue-Bold" size:18.f]
#define kFontName [UIFont fontWithName:@"HelveticaNeue-Bold" size:15.f]
#define kFontBirthdayDate [UIFont fontWithName:@"HelveticaNeue" size:13.f]
#define kFontDaysUntilBirthday [UIFont fontWithName:@"HelveticaNeue-Bold" size:25.f]
#define kFontDaysUntillBirthdaySubText [UIFont fontWithName:@"HelveticaNeue" size:9.f]
#define kFontLarge [UIFont fontWithName:@"HelveticaNeue-Bold" size:17.f]
#define kFontButton [UIFont fontWithName:@"HelveticaNeue-Bold" size:30.f]
#define kFontNotes [UIFont fontWithName:@"HelveticaNeue" size:16.f]
#define kFontPicPhoto [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.f]
#define kFontDropShadowColour [UIColor colorWithRed:1.0/255 green:1.0/255 blue:1.0/255 alpha:0.75]

@implementation BRStyleSheet

+(void)styleLabel:(UILabel *)label withType:(BRLabelType)labelType{
    switch (labelType) {
        case BRLabelTypeName:
            label.font = kFontName;
            label.layer.shadowColor = kFontDropShadowColour.CGColor;
            label.layer.shadowOffset = CGSizeMake(1.0f, 1.f);
            label.layer.shadowRadius = 0.f;
            label.layer.masksToBounds = NO;
            label.textColor = kFontLightOnDarkTextColour;
            break;
        case BRLabelTypeBirthdayDate:
            label.font = kFontBirthdayDate;
            label.textColor = kFontLightOnDarkTextColour;
            break;
        case BRLabelTypeDaysUntilBirthday:
            label.font = kFontDaysUntilBirthday;
            label.textColor = kFontDarkOnLightTextColour;
            break;
        case BRLabelTypeDaysUntilBirthdaySubText:
            label.font = kFontDaysUntillBirthdaySubText;
            label.textColor = kFontDarkOnLightTextColour;
            break;
        case BRLabelTypeLarge:
            label.textColor = kFontLightOnDarkTextColour;
            label.layer.shadowColor = kFontDropShadowColour.CGColor;
            label.layer.shadowOffset = CGSizeMake(1.f, 1.f);
            label.layer.shadowRadius = 0.f;
            label.layer.masksToBounds = NO;
            break;
        default:
            label.textColor = kFontLightOnDarkTextColour;
            break;
    }
}

+(void)styleRoundCorneredView:(UIView *)view{
    view.layer.cornerRadius = 4.f;
    view.layer.masksToBounds = YES;
    view.clipsToBounds = YES;
}

+(void)initStyles{
    NSDictionary *titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:kFontNavigationTextColour, UITextAttributeTextColor, [UIColor whiteColor], UITextAttributeTextShadowColor, [NSValue valueWithUIOffset:UIOffsetMake(0, 2)], UITextAttributeTextShadowOffset, kFontNavigation, UITextAttributeFont, nil];
    [[UINavigationBar appearance] setTitleTextAttributes:titleTextAttributes];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigation-bar-background.png"] forBarMetrics:UIBarMetricsDefault];
    
    NSDictionary *barButtonItemTextAttributes;
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTintColor:kNavigationButtonBackgroundColour];
    barButtonItemTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:kFontNavigationTextColour, UITextAttributeTextColor, [UIColor whiteColor], UITextAttributeTextShadowColor, [NSValue valueWithUIOffset:UIOffsetMake(0, 1)], UITextAttributeTextShadowOffset, nil];
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:barButtonItemTextAttributes forState:UIControlStateNormal];
    NSDictionary *disabledBarButtonItemTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:kFontNavigationDisabledTextColour, UITextAttributeTextColor, [UIColor whiteColor], UITextAttributeTextShadowColor, [NSValue valueWithUIOffset:UIOffsetMake(0, 1)], UITextAttributeTextShadowOffset, nil];
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:disabledBarButtonItemTextAttributes forState:UIControlStateDisabled];
    
    [[UIToolbar appearance] setBackgroundImage:[UIImage imageNamed:@"tool-bar-background.png"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearanceWhenContainedIn:[UIToolbar class], nil] setTintColor:kToolbarButtonBackgroundColour];
    barButtonItemTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, nil];
    [[UIBarButtonItem appearanceWhenContainedIn:[UIToolbar class], nil] setTitleTextAttributes:barButtonItemTextAttributes forState:UIControlStateNormal];
    
    [[BRBlueButton appearance] setBackgroundImage:[UIImage imageNamed:@"button-blue.png"] forState:UIControlStateNormal];
    [[BRBlueButton appearance] setTitleColor:kLargeButtonTextColour forState:UIControlStateNormal];
    [[BRBlueButton appearance] setFont:kFontLarge];
    
    [[BRRedButton appearance] setBackgroundImage:[UIImage imageNamed:@"button-red.png"] forState:UIControlStateNormal];
    [[BRRedButton appearance] setTitleColor:kLargeButtonTextColour forState:UIControlStateNormal];
    [[BRRedButton appearance] setFont:kFontLarge];
    
}

+(void)styleTextView:(UITextView *)textView{
    textView.backgroundColor = [UIColor clearColor];
    textView.font = kFontNotes;
    textView.textColor = kFontLightOnDarkTextColour;
    textView.layer.shadowColor = kFontDropShadowColour.CGColor;
    textView.layer.shadowOffset = CGSizeMake(1.f, 1.f);
    textView.layer.shadowRadius = 0.0f;
    textView.layer.masksToBounds = NO;
}
@end
