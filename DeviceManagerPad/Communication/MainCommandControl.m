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
#import "TcpSwitchControl.h"


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
    
    [self powerOnAllProjector];

    
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
    
    [self powerOffAllProjector];

    
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

-(void)powerOnAllProjector
{
    NSArray*deviceArray =nil;
    deviceArray=[[CoreDataAdaptor instance]deviceArray:DeviceTypeProjection];
    
    [deviceArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        RemoteDevice*device=(RemoteDevice*)obj;
        
        TcpSwitchControl*tcpControl =[[TcpSwitchControl alloc]initWithDevice:device];
        
        [tcpControl checkConnection];
        sleep(1);
        tcpControl.powerOnCommand = [[NSUserDefaults standardUserDefaults]objectForKey:ProjectionPowerOnKey];
        tcpControl.quickShotCommand = [[NSUserDefaults standardUserDefaults]objectForKey:ProjectionPowerOnKey];
        [tcpControl powerOnDevice:device];
        [tcpControl disconnect];
        
    }];
    
}
-(void)powerOffAllProjector
{
    NSArray*deviceArray =nil;
    deviceArray=[[CoreDataAdaptor instance]deviceArray:DeviceTypeProjection];

    [deviceArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        RemoteDevice*device=(RemoteDevice*)obj;
        TcpSwitchControl*tcpControl =[[TcpSwitchControl alloc]initWithDevice:device];
        [tcpControl checkConnection];
        sleep(1);
        tcpControl.powerOffCommand = [[NSUserDefaults standardUserDefaults]objectForKey:ProjectionPowerOffKey];
        [tcpControl powerOffDevice:device];
        [tcpControl disconnect];
    
        
    }];
}


@end
