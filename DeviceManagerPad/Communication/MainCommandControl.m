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
#import "DeviceCommunication.h"
#import "TcpSwitchControl.h"


@implementation MainCommandControl

@synthesize udpSocket;

-(instancetype)initWithUdpSocket:(GCDAsyncUdpSocket*)socket{
    self=[super init];
    self.udpSocket=socket;
    return self;
}

-(void)sendPowerOn:(RemoteDevice*)device{
    
    SwitchCommandControl*swithCommandCtrl=[[SwitchCommandControl alloc]initWithUdpSocket:self.udpSocket];
    swithCommandCtrl.repeatTime = [self clusterRepeatTime];

    NSArray*deviceArray=[[CoreDataAdaptor instance] deviceArray:DeviceTypeCluster];
    [deviceArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        RemoteDevice*device=(RemoteDevice*)obj;
        swithCommandCtrl.powerOnCommand = device.powerOnCmd;
        [swithCommandCtrl sendPowerOn:device];
        //[swithCommandCtrl sendPowerOn:device.deviceIP port:device.port.integerValue];
    }];
    
    [self powerOnAllProjector];



}


-(NSInteger)clusterRepeatTime
{
    NSInteger repTime = [[NSUserDefaults standardUserDefaults] integerForKey:ClusterRepeatTimeKey];
    if(repTime<=0)
    {
        repTime =3;
    }
    
    return repTime;
    
}
-(void)sendPowerOff:(RemoteDevice*)device{
    
    SwitchCommandControl*swithCommandCtrl=[[SwitchCommandControl alloc]initWithUdpSocket:self.udpSocket];
    swithCommandCtrl.repeatTime = [self clusterRepeatTime];
    
    NSArray*deviceArray=[[CoreDataAdaptor instance] deviceArray:DeviceTypeCluster];
    [deviceArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        RemoteDevice*device=(RemoteDevice*)obj;
        swithCommandCtrl.powerOffCommand = device.powerOffCmd;
        [swithCommandCtrl sendPowerOff:device];
        //[swithCommandCtrl sendPowerOff:device.deviceIP port:device.port.integerValue];
    }];
    
    [self powerOffAllProjector];

    
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
        tcpControl.quickShotCommand = [[NSUserDefaults standardUserDefaults]objectForKey:ProjectionQuickShotKey];
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
