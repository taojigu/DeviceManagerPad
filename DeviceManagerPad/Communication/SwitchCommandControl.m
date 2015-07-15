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


@implementation SwitchCommandControl

@synthesize powerOnCommand;
@synthesize powerOffCommand;
@synthesize udpSocket;

-(instancetype)initWithUdpSocket:(GCDAsyncUdpSocket*)socket{
    self=[super init];
    self.udpSocket=socket;
    return self;
}

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



@end
