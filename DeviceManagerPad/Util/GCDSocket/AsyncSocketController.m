//
//  AsyncSocketController.m
//  DeviceManagerPad
//
//  Created by gus on 15/7/15.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import "AsyncSocketController.h"

@interface AsyncSocketController ()<GCDAsyncSocketDelegate>

@end

@implementation AsyncSocketController

-(instancetype)init
{
    self = [super init];
    self.tcpSocket=[[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    return self;
}

-(instancetype)initAsyncSocketWith:(NSString*)urlString port:(NSInteger)port
{
    
    self=[super init];
    
    return self;
}

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    NSLog(@"Tcp connect to %@:%@",host,[NSNumber numberWithInt:port]);
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"Did write data with Tag %@",[NSNumber numberWithLong:tag]);
}

@end
