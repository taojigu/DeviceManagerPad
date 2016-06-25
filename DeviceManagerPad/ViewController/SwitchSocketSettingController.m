//
//  SwitchSocketSettingController.m
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/21.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import "SwitchSocketSettingController.h"


#define DefaultRepateTime 3


@interface SwitchSocketSettingController (){
    
}

@property(nonatomic,strong)IBOutlet UITextField*tfRepeatTime;

@end

@implementation SwitchSocketSettingController{
    
}



@synthesize powerOnCommandKey;
@synthesize powerOffCommandKey;


-(void)viewDidLoad{
    [super viewDidLoad];
    [self refresh];
}

-(IBAction)saveCommands:(id)sender{

    
    NSUInteger repeatTime = [self.tfRepeatTime.text integerValue];
    if (repeatTime<=0)
    {
        return;
    }
    
    [[NSUserDefaults standardUserDefaults] setInteger:repeatTime forKey:self.repeateTimeKey];
    
    
}



#pragma mark -- private messages
-(void)refresh{

    //self.tfPowerOnCommand.text=[[NSUserDefaults standardUserDefaults]objectForKey:self.powerOnCommandKey];
    //self.tfPowerOffCommand.text=[[NSUserDefaults standardUserDefaults]objectForKey:self.powerOffCommandKey];
    
    NSInteger repeatTime = [[NSUserDefaults standardUserDefaults] integerForKey:self.repeateTimeKey];
    if (repeatTime==0)
    {
        repeatTime = DefaultRepateTime;
        [[NSUserDefaults standardUserDefaults] setInteger:repeatTime forKey:self.repeateTimeKey];
    }
    
    self.tfRepeatTime.text = [NSString stringWithFormat:@"%li",repeatTime];
    
}

@end
