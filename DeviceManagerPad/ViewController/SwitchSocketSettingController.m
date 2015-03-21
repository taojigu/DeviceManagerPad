//
//  SwitchSocketSettingController.m
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/21.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import "SwitchSocketSettingController.h"


@interface SwitchSocketSettingController (){
    
}

@property(nonatomic,strong)IBOutlet UITextField*tfPowerOnCommand;
@property(nonatomic,strong)IBOutlet UITextField*tfPowerOffCommand;

@end

@implementation SwitchSocketSettingController{
    
}

@synthesize tfPowerOnCommand;
@synthesize tfPowerOffCommand;

@synthesize powerOnCommandKey;
@synthesize powerOffCommandKey;


-(void)viewDidLoad{
    [super viewDidLoad];
    [self refresh];
}

-(IBAction)saveCommands:(id)sender{
    [[NSUserDefaults standardUserDefaults] setObject:self.tfPowerOnCommand.text forKey:self.powerOnCommandKey];
    [[NSUserDefaults standardUserDefaults] setObject:self.tfPowerOffCommand.text forKey:self.powerOffCommandKey];
}



#pragma mark -- private messages
-(void)refresh{

    self.tfPowerOnCommand.text=[[NSUserDefaults standardUserDefaults]objectForKey:self.powerOnCommandKey];
    self.tfPowerOffCommand.text=[[NSUserDefaults standardUserDefaults]objectForKey:self.powerOffCommandKey];
    
}

@end
