//
//  StereoSocketSettingViewController.m
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/21.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import "StereoSocketSettingViewController.h"
#import "DeviceCommunication.h"



@interface StereoSocketSettingViewController (){
    
}

@property(nonatomic,strong)IBOutlet UITextField*tfPowerOn;
@property(nonatomic,strong)IBOutlet UITextField*tfPowerOff;
@property(nonatomic,strong)IBOutlet UITextField*tfVolumeUp;
@property(nonatomic,strong)IBOutlet UITextField*tfVolumeDown;


-(IBAction)saveButtonClicked:(id)sender;

@end
@implementation StereoSocketSettingViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self refresh];
}

-(IBAction)saveButtonClicked:(id)sender{
    [self saveStereoSetting];
}

-(void)saveStereoSetting{
    
    NSUserDefaults*defaultSetting=[NSUserDefaults standardUserDefaults];
    [defaultSetting setObject:self.tfPowerOn.text forKey:StereoPowerOnKey];
    [defaultSetting setObject:self.tfPowerOff.text forKey:StereoPowerOffKey];
    [defaultSetting setObject:self.tfVolumeUp.text forKey:SteroVolumeUpKey];
    [defaultSetting setObject:self.tfVolumeDown.text forKey:SteroVolumnDownKey];
    
}
-(void)refresh{
    
    [self refreshTextField:self.tfPowerOn withKey:StereoPowerOnKey];
    [self refreshTextField:self.tfPowerOff withKey:StereoPowerOffKey];
    [self refreshTextField:self.tfVolumeUp withKey:SteroVolumeUpKey];
    [self refreshTextField:self.tfVolumeDown withKey:SteroVolumnDownKey];
}

-(void)refreshTextField:(UITextField*)textField withKey:(NSString*)key{
    NSString*text=[[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (text.length!=0) {
        textField.text=text;
    }
}
@end
