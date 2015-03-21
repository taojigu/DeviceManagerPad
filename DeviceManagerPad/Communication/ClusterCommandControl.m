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
    
    command = [command stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSMutableData *commandToSend= [[NSMutableData alloc] init];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    int i;
    for (i=0; i < [command length]/2; i++) {
        byte_chars[0] = [command characterAtIndex:i*2];
        byte_chars[1] = [command characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [commandToSend appendBytes:&whole_byte length:1];
    }
    
    NSLog(@"Command to send %@",command);
    
    [self.udpSocket sendData:commandToSend toHost:TargetIP port:1000 withTimeout:-1 tag:1001];

    
}
-(void)sendPowerOff:(NSString*)hostAddress port:(NSInteger)port{
    
}


@end
