//
//  SwitchCell.m
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/16.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import "SwitchCell.h"



@interface SwitchCell (){
    
}

@end

@implementation SwitchCell


@synthesize powerOnButton;
@synthesize powerOffButton;
@synthesize titleLabel;
@synthesize subTitleLabel;


- (void)awakeFromNib {
    
    // Initialization code
    [self.powerOffButton setBackgroundColor:[UIColor colorWithRed:186/255 green:184/255 blue:184/255 alpha:0.56]];
    //self.powerOffButton.layer.cornerRadius = 30;
    
    [self.powerOnButton setBackgroundColor:[UIColor colorWithRed:186/255 green:184/255 blue:184/255 alpha:0.56]];
    //self.powerOnButton.layer.cornerRadius =30;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
