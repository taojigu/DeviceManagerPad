//
//  MainCommandControl.m
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/17.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import "MainCommandControl.h"
#import "RemoteDevice.h"
#import "CoreDataAdaptor.h"
#import "SwitchCommandControl.h"
#import "StereoCommandControl.h"
#import "DeviceCommunication.h"


@implementation MainCommandControl

@synthesize udpSocket;

-(instancetype)initWithUdpSocket:(GCDAsyncUdpSocket*)socket{
    self=[super init];
    self.udpSocket=socket;
    return self;
}

-(void)sendPowerOn:(NSString*)hostAddress port:(NSInteger)port{
    
    SwitchCommandControl*swithCommandCtrl=[[SwitchCommandControl alloc]initWithUdpSocket:self.udpSocket];
    swithCommandCtrl.powerOnCommand=[[NSUserDefaults standardUserDefaults]objectForKey:ClusterPowerOnKey];
    
    NSArray*deviceArray=[[CoreDataAdaptor instance] deviceArray:DeviceTypeCluster];
    [deviceArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        RemoteDevice*device=(RemoteDevice*)obj;
        [swithCommandCtrl sendPowerOn:device.deviceIP port:device.port.integerValue];
    }];
    
    deviceArray=[[CoreDataAdaptor instance]deviceArray:DeviceTypeProjection];
    swithCommandCtrl.powerOnCommand=[[NSUserDefaults standardUserDefaults]objectForKey:ProjectionPowerOnKey];
    [deviceArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        RemoteDevice*device=(RemoteDevice*)obj;
        [swithCommandCtrl sendPowerOn:device.deviceIP port:device.port.integerValue];

    }];
    
    swithCommandCtrl.powerOnCommand=[[NSUserDefaults standardUserDefaults]objectForKey:SoftwarePowerOnKey];
    deviceArray=[[CoreDataAdaptor instance]deviceArray:DeviceTypeSoftware];
    [deviceArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        RemoteDevice*device=(RemoteDevice*)obj;
        [swithCommandCtrl sendPowerOn:device.deviceIP port:device.port.integerValue];
    }];
    
    StereoCommandControl*steroCtrl=[[StereoCommandControl alloc]initWithUdpSocket:self.udpSocket];
    deviceArray=[[CoreDataAdaptor instance]deviceArray:DeviceTypeStereo];
    [deviceArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        RemoteDevice*device=(RemoteDevice*)obj;
        [steroCtrl sendPowerOn:device.deviceIP port:device.port.integerValue];

    }];
    

}
-(void)sendPowerOff:(NSString*)hostAddress port:(NSInteger)port{
    SwitchCommandControl*swithCommandCtrl=[[SwitchCommandControl alloc]initWithUdpSocket:self.udpSocket];
    swithCommandCtrl.powerOffCommand=[[NSUserDefaults standardUserDefaults]objectForKey:ClusterPowerOffKey];
    
    NSArray*deviceArray=[[CoreDataAdaptor instance] deviceArray:DeviceTypeCluster];
    [deviceArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        RemoteDevice*device=(RemoteDevice*)obj;
        [swithCommandCtrl sendPowerOff:device.deviceIP port:device.port.integerValue];
    }];
    
    deviceArray=[[CoreDataAdaptor instance]deviceArray:DeviceTypeProjection];
    swithCommandCtrl.powerOffCommand=[[NSUserDefaults standardUserDefaults]objectForKey:ProjectionPowerOffKey];
    [deviceArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        RemoteDevice*device=(RemoteDevice*)obj;
        [swithCommandCtrl sendPowerOff:device.deviceIP port:device.port.integerValue];
        
    }];
    
    swithCommandCtrl.powerOffCommand=[[NSUserDefaults standardUserDefaults]objectForKey:SoftwarePowerOffKey];
    deviceArray=[[CoreDataAdaptor instance]deviceArray:DeviceTypeSoftware];
    [deviceArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        RemoteDevice*device=(RemoteDevice*)obj;
        [swithCommandCtrl sendPowerOff:device.deviceIP port:device.port.integerValue];
    }];
    
    StereoCommandControl*steroCtrl=[[StereoCommandControl alloc]initWithUdpSocket:self.udpSocket];
    deviceArray=[[CoreDataAdaptor instance]deviceArray:DeviceTypeStereo];
    [deviceArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        RemoteDevice*device=(RemoteDevice*)obj;
        [steroCtrl sendPowerOff:device.deviceIP port:device.port.integerValue];
        
    }];
    
}


@end
