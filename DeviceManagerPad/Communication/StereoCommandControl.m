//
//  StereoCommandControl.m
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/17.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import "StereoCommandControl.h"
#import "DeviceCommunication.h"
#import "SocketUtility.h"

@implementation StereoCommandControl


-(instancetype)initWithUdpSocket:(GCDAsyncUdpSocket*)udpSocket{
    self=[super init];
    self.udpSocket=udpSocket;
    return self;
}

-(void)sendPowerOn:(NSString*)hostAddress port:(NSInteger)port{
    NSString*commandText=[[NSUserDefaults standardUserDefaults] objectForKey:StereoPowerOnKey];
    NSData*data=[SocketUtility hexDataFromNSString:commandText];
    [self.udpSocket sendData:data toHost:hostAddress port:port withTimeout:-1 tag:PowerOnTag];
    
}
-(void)sendPowerOff:(NSString*)hostAddress port:(NSInteger)port{
    NSString*commandText=[[NSUserDefaults standardUserDefaults] objectForKey:StereoPowerOffKey];
    NSData*data=[SocketUtility hexDataFromNSString:commandText];
    [self.udpSocket sendData:data toHost:hostAddress port:port withTimeout:-1 tag:PowerOffTag];
}
-(void)sendVolumeUp:(NSString *)hostAddress port:(NSInteger)port{
    NSString*commandText=[[NSUserDefaults standardUserDefaults] objectForKey:SteroVolumeUpKey];
    NSData*data=[SocketUtility hexDataFromNSString:commandText];
    [self.udpSocket sendData:data toHost:hostAddress port:port withTimeout:-1 tag:VolumeUpTag];
}
-(void)sendVolumeDown:(NSString *)hostAddress port:(NSInteger)port{
    NSString*commandText=[[NSUserDefaults standardUserDefaults] objectForKey:SteroVolumnDownKey];
    NSData*data=[SocketUtility hexDataFromNSString:commandText];
    [self.udpSocket sendData:data toHost:hostAddress port:port withTimeout:-1 tag:VolumeDownTag];
}
@end
