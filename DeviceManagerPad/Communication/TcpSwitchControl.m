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
#import "RemoteDevice.h"
@interface TcpSwitchControl ()<GCDAsyncSocketDelegate>
{
    
}







@end

@implementation TcpSwitchControl


-(instancetype)initWithDevice:(RemoteDevice *)device
{
    self = [super init];
    self.device =device;
    self.tcpSocket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];

    return self;
    
}

-(void)connectAndPowerOn:(RemoteDevice*)device
{
    [self checkConnection];
    [self sendPowerOn:device.deviceIP port:[device.port intValue]];
}
-(void)powerOnDevice:(RemoteDevice*)device
{
    [self sendPowerOn:device.deviceIP port:[device.port intValue]];
}
-(void)powerOffDevice:(RemoteDevice*)device
{
    NSData*powerOffData=[SocketUtility hexDataFromNSString:self.powerOffCommand];
    [self.tcpSocket writeData:powerOffData withTimeout:2 tag:PowerOffTag];

}

-(void)sendPowerOn:(NSString*)hostAddress port:(NSInteger)port
{

    NSData*refreshData = [SocketUtility hexDataFromNSString:self.quickShotCommand];
    [self.tcpSocket writeData:refreshData withTimeout:2 tag:QuickShotTag];
    [NSThread sleepForTimeInterval:0.1];
    
    NSData*powerOnData=[SocketUtility hexDataFromNSString:self.powerOnCommand];
    [self.tcpSocket writeData:powerOnData withTimeout:2 tag:PowerOnTag];

}
-(void)sendPowerOff:(NSString*)hostAddress port:(NSInteger)port
{
    NSData*powerOffData = [SocketUtility hexDataFromNSString:self.powerOffCommand];
    [self.tcpSocket writeData:powerOffData withTimeout:10 tag:PowerOffTag];
}

-(void)disconnect
{
    [self.tcpSocket disconnectAfterReadingAndWriting];
}
-(void)checkConnection
{
    NSString*hostAddress =self.device.deviceIP;
    uint16_t port = [self.device.port integerValue];
    
    if (self.tcpSocket.isConnected&&[self.tcpSocket.connectedHost isEqual:hostAddress])
    {
        return;
    }
    

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

-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    NSLog(@"Did Connect");
    [self sendPowerOn:self.device.deviceIP port:[self.device.port intValue]];
}
-(void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"Tcp did write data");

}



@end
