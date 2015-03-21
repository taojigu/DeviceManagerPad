//
//  AsyncSocketController.m
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/12.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import "AsyncUdpSocketController.h"

#import "GCDAsyncUdpSocket.h"

@implementation AsyncUdpSocketController

@synthesize udpSocket;

-(instancetype)init{
    
    self=[super init];
    self.udpSocket=[[GCDAsyncUdpSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    return self;
}

/**
 * Called when the datagram with the given tag has been sent.
 **/
- (void)udpSocket:(GCDAsyncUdpSocket *)sock didSendDataWithTag:(long)tag{
    NSLog(@"Socket send suess");
}

/**
 * Called if an error occurs while trying to send a datagram.
 * This could be due to a timeout, or something more serious such as the data being too large to fit in a sigle packet.
 **/
- (void)udpSocket:(GCDAsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error{
    NSLog(@"Socket send error :%@",[error localizedDescription]);
}



@end
