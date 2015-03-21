//
//  ClusterCommandControl.m
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/17.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import "ClusterCommandControl.h"
#import "FakeSocketFactory.h"
#import "GCDAsyncUdpSocket.h"


#define TargetIP @"10.105.41.135"

@implementation ClusterCommandControl

@synthesize udpSocket;

-(instancetype)initWithUdpSocket:(GCDAsyncUdpSocket*)socket{
    self=[super init];
    self.udpSocket=socket;
    return self;
}

-(void)sendPowerOn:(NSString*)hostAddress port:(NSInteger)port{
    
    
    NSString *command = @"72ff63cea198b3edba8f7e0c23acc345050187a0cde5a9872cbab091ab73e553";
    
       
    NSLog(@"Command to send %@",command);
    
    [self.udpSocket sendData:nil toHost:nil port:1000 withTimeout:-1 tag:1001];

    
}
-(void)sendPowerOff:(NSString*)hostAddress port:(NSInteger)port{
    
}


@end
