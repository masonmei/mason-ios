//
//  BRStyleSheet.h
//  BirthdayReminder
//
//  Created by Mason Mei on 3/29/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : int {
    BRLabelTypeName = 0,
    BRLabelTypeBirthdayDate,
    BRLabelTypeDaysUntilBirthday,
    BRLabelTypeDaysUntilBirthdaySubText,
    BRLabelTypeLarge
}BRLabelType;
    
    

@interface BRStyleSheet : NSObject

+(void) styleLabel: (UILabel *) label withType:(BRLabelType) labelType;
+(void) styleRoundCorneredView:(UIView *)view;
+(void) initStyles;
+(void) styleTextView:(UITextView *)textView;
@end
