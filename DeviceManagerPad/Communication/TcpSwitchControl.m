//
//  TcpSwitchControl.m
//  DeviceManagerPad
//
//  Created by gus on 15/7/15.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import "TcpSwitchControl.h"
#import "GCDAsyncSocket.h"
#import "SocketUtility.h"
#import "DeviceCommunication.h"
@interface TcpSwitchControl ()
{
    
}


@end

@implementation TcpSwitchControl



-(instancetype)initWithTcpSocket:(GCDAsyncSocket*)tcpSockt
{
    self = [super init];
    self.tcpSocket =tcpSockt;
    return self;
    
}

-(void)sendPowerOn:(NSString*)hostAddress port:(NSInteger)port
{
    [self checkConnection:hostAddress port:port];
    NSData*powerOnData=[SocketUtility hexDataFromNSString:self.powerOnCommand];
    [self.tcpSocket writeData:powerOnData withTimeout:10 tag:PowerOnTag];
    
}
-(void)sendPowerOff:(NSString*)hostAddress port:(NSInteger)port
{
    NSData*powerOffData = [SocketUtility hexDataFromNSString:self.powerOffCommand];
    [self.tcpSocket writeData:powerOffData withTimeout:10 tag:PowerOffTag];
}

-(void)checkConnection:(NSString*)hostAddress port:(uint16_t)port
{
    if (self.tcpSocket.isConnected&&[self.tcpSocket.connectedHost isEqual:hostAddress])
    {
        return;
    }
    
    [self.tcpSocket disconnect];
    NSError* error = nil;
    BOOL connecdtReult =[self.tcpSocket connectToHost:hostAddress onPort:port error:&error];
    if (connecdtReult)
    {
        NSLog(@"Connect %@ success",hostAddress);
    }
    else
    {
        NSLog(@"Connect %@ failed",hostAddress);
    }
    if (nil!=error)
    {
        NSLog(@"Connect Tcp %@ error：%@ ",hostAddress,[error localizedDescription]);
    }
}



@end
