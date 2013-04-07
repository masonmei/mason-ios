//
//  BRBrithdayTableViewCell.m
//  BirthdayReminder
//
//  Created by Mason Mei on 3/29/13.
//  Copyright (c) 2013 Mason Mei. All rights reserved.
//

#import "BRBrithdayTableViewCell.h"
#import "BRDBirthday.h"
#import "BRStyleSheet.h"
#import "BRDBirthdayImport.h"
#import "UIImageView+RemoteFile.h"

@implementation BRBrithdayTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setBirthday:(BRDBirthday *)birthday{
    _birthday = birthday;
    self.nameLabel.text = _birthday.name;
    int days = _birthday.remainingDaysUntilNextBirthday;
    if(days == 0){
        self.remainingDaysLabel.text = self.remainingDaysSubTextLabel.text = @"";
        self.remainingDaysImageView.image = [UIImage imageNamed:@"icon-birthday.cake.png"];
    }else{
        self.remainingDaysLabel.text = [NSString stringWithFormat:@"%d", days];
        self.remainingDaysSubTextLabel.text = (days == 1)? @"more day" : @"more days";
        self.remainingDaysImageView.image = [UIImage imageNamed:@"icon-days-remaining.png"];
    }
    
    self.birthdayLabel.text = _birthday.birthdayTextToDisplay;
    
    if(birthday.imageData == nil){
        if([_birthday.picURL length] > 0){
            [self.iconView setImageWithRemoteFileURL:_birthday.picURL placeHolderImage:[UIImage imageNamed:@"icon-birthday-cake.png"]];
        }else {
            self.iconView.image = [UIImage imageNamed:@"icon-birthday-cake.png"];
        }
    }else{
        self.iconView.image = [UIImage imageWithData:_birthday.imageData];
    }
}

-(void)setBirthdayImport:(BRDBirthdayImport *)birthdayImport{
    _birthdayImport = birthdayImport;
    self.nameLabel.text = _birthdayImport.name;
    
    int days = _birthdayImport.remainingDaysUntilNextBirthday;
    
    if(days == 0){
        self.remainingDaysLabel.text = self.remainingDaysSubTextLabel.text = @"";
        self.remainingDaysImageView.image = [UIImage imageNamed:@"icon-birthday-cake.png"];
    } else {
        self.remainingDaysLabel.text = [NSString stringWithFormat:@"%d", days];
        self.remainingDaysSubTextLabel.text = (days == 1)? @"more day" : @"more days";
        self.remainingDaysImageView.image = [UIImage imageNamed:@"icon-days-remaining.png"];
    }
    
    self.birthdayLabel.text = _birthdayImport.birthdayTextToDisplay;
    
    if(_birthdayImport.imageData == nil){
        if([_birthdayImport.picURL length] > 0){
            [self.iconView setImageWithRemoteFileURL:birthdayImport.picURL placeHolderImage:[UIImage imageNamed:@"icon-birthday-cake.png"]];
        }else{
            [self.iconView setImage:[UIImage imageNamed:@"icon-birthday-cake.png"]];
        }
    } else {
        self.iconView.image = [UIImage imageWithData:birthdayImport.imageData];
    }
}

-(void)setIconView:(UIImageView *)iconView{
    _iconView = iconView;
    if(_iconView){
        [BRStyleSheet styleRoundCorneredView:_iconView];
    }
}

-(void)setNameLabel:(UILabel *)nameLabel{
    _nameLabel = nameLabel;
    if(_nameLabel){
        [BRStyleSheet styleLabel:_nameLabel withType:BRLabelTypeName];
    }
}

-(void)setBirthdayLabel:(UILabel *)birthdayLabel{
    _birthdayLabel = birthdayLabel;
    if(_birthdayLabel){
        [BRStyleSheet styleLabel:_birthdayLabel withType:BRLabelTypeBirthdayDate];
    }
}

-(void)setRemainingDaysLabel:(UILabel *)remainingDaysLabel{
    _remainingDaysLabel = remainingDaysLabel;
    if(_remainingDaysLabel){
        [BRStyleSheet styleLabel:_remainingDaysLabel withType:BRLabelTypeDaysUntilBirthday];
    }
}

-(void)setRemainingDaysSubTextLabel:(UILabel *)remainingDaysSubTextLabel{
    _remainingDaysSubTextLabel = remainingDaysSubTextLabel;
    if(_remainingDaysSubTextLabel){
        [BRStyleSheet styleLabel:_remainingDaysSubTextLabel withType:BRLabelTypeDaysUntilBirthdaySubText];
    }
}
@end
