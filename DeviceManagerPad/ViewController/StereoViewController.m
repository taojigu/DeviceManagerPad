//
//  StereoViewController.m
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/18.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import "StereoViewController.h"
#import "RemoteDevice.h"
#import "CoreDataAdaptor.h"

@interface StereoViewController(){
    
}

@property (nonatomic,strong)RemoteDevice*device;
@property(nonatomic,strong)IBOutlet UIButton*saveButton;
@property(nonatomic,strong)IBOutlet UITextField*tfAddress;
@property(nonatomic,strong)IBOutlet UITextField*tfPort;



-(IBAction)sendPowerOn:(id)sender;
-(IBAction)sendPowerOff:(id)sender;
-(IBAction)sendVolumeUp:(id)sender;
-(IBAction)sendVolumeDown:(id)sender;
-(IBAction)saveButtonClicked:(id)sender;

@end

@implementation StereoViewController

@synthesize communication;
@synthesize editable;

@synthesize saveButton;
@synthesize tfAddress;
@synthesize tfPort;


-(void)viewDidLoad{
    
    [super viewDidLoad];
    self.tfAddress.hidden=!self.editable;
    self.tfPort.hidden=!self.editable;
    self.saveButton.hidden=!self.editable;
    
    [self readDeviceDate];
    [self refresh];
    return;
}


#pragma -- mark selector messages
-(IBAction)sendPowerOn:(id)sender{
    
    [self.communication sendPowerOn:self.device.deviceIP port:[self.device.port integerValue]];
    
}
-(IBAction)sendPowerOff:(id)sender{
    [self.communication sendPowerOff:self.device.deviceIP port:[self.device.port integerValue]];
}
-(IBAction)sendVolumeUp:(id)sender{
    [self.communication sendVolumeUp:self.device.deviceIP port:[self.device.port integerValue]];
}
-(IBAction)sendVolumeDown:(id)sender{
    [self.communication sendVolumeDown:self.device.deviceIP port:[self.device.port integerValue]];
}
-(IBAction)saveButtonClicked:(id)sender{
    [self saveDevice];
}
#pragma -- private messages

-(void)saveDevice{
    self.device.deviceIP=self.tfAddress.text;
    self.device.port=[NSNumber numberWithInteger:[self.tfPort.text integerValue]];
    [[CoreDataAdaptor instance] saveCurrentChanges:nil];
}

-(void)readDeviceDate{
    NSArray*devArray=[[CoreDataAdaptor instance]deviceArray:DeviceTypeStereo];
    if (nil==devArray||devArray.count==0) {
        self.device=[[CoreDataAdaptor instance]createNewDevice];
        self.device.type=[NSNumber numberWithInteger:DeviceTypeStereo];
        self.device.name=@"StereoDevice";
    }else{
        self.device=[devArray objectAtIndex:0];
    }
    
}
-(void)refresh{
    if (self.device.deviceIP.length>0) {
        self.tfAddress.text=self.device.deviceIP;
    }
    
    if (self.device.port!=nil) {
        self.tfPort.text=[self.device.port stringValue];
    }
}


@end
