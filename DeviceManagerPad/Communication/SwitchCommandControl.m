//
//  SwitchCommandControl.m
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/21.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import "SwitchCommandControl.h"
#import "SocketUtility.h"
#import "DeviceCommunication.h"
#import "RemoteDevice.h"


@implementation SwitchCommandControl

@synthesize powerOnCommand;
@synthesize powerOffCommand;
@synthesize udpSocket;

-(instancetype)initWithUdpSocket:(GCDAsyncUdpSocket*)socket{
    self=[super init];
    self.udpSocket=socket;
    self.repeatTime = 1;
    return self;
}
/*
-(void)sendPowerOn:(NSString*)hostAddress port:(NSInteger)port{
    

    NSLog(@"PowerOn Command is %@",self.powerOnCommand);
    NSData*powerOnData=[SocketUtility hexDataFromNSString:self.powerOnCommand];
    NSString* powerOnString = [[NSString alloc]initWithData:powerOnData encoding:NSUTF8StringEncoding];
    NSLog(@"Power on commnand Data string is:%@",powerOnString);
    [self.udpSocket sendData:powerOnData toHost:hostAddress port:port withTimeout:2 tag:PowerOnTag];
}
-(void)sendPowerOff:(NSString*)hostAddress port:(NSInteger)port{
    
    NSData*powerOnData=[SocketUtility hexDataFromNSString:self.powerOffCommand];
    [self.udpSocket sendData:powerOnData toHost:hostAddress port:port withTimeout:2 tag:PowerOnTag];
}
 */


-(void)sendPowerOn:(RemoteDevice*)device;
{
    NSString* powerOnCmd = self.powerOnCommand;
    if (device.powerOnCmd.length>0)
    {
        powerOnCmd = device.powerOnCmd;
    }
    NSLog(@"PowerOn Command is %@",powerOnCmd);
    NSData*powerOnData=[SocketUtility hexDataFromNSString:powerOnCmd];
    NSString* powerOnString = [[NSString alloc]initWithData:powerOnData encoding:NSUTF8StringEncoding];
    NSLog(@"Power on commnand Data string is:%@",powerOnString);
    
    for (NSInteger repIndex=0; repIndex<self.repeatTime; repIndex++)
    {
        [self.udpSocket sendData:powerOnData toHost:device.deviceIP port:device.port.integerValue withTimeout:2 tag:PowerOnTag];
        [NSThread sleepForTimeInterval:0.1];
    }
    

    
}
-(void)sendPowerOff:(RemoteDevice*)device{
    
    NSString* powerOffCmd = self.powerOffCommand;
    if (device.powerOffCmd.length>0)
    {
        powerOffCmd = device.powerOffCmd;
    }
    
    NSData*powerOnData=[SocketUtility hexDataFromNSString:powerOffCmd];
     for (NSInteger repIndex=0; repIndex<self.repeatTime; repIndex++)
     {
         [self.udpSocket sendData:powerOnData toHost:device.deviceIP port:device.port.integerValue withTimeout:2 tag:PowerOnTag];
         [NSThread sleepForTimeInterval:0.1];
     }
}


@end
