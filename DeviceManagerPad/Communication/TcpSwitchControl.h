//
//  TcpSwitchControl.h
//  DeviceManagerPad
//
//  Created by gus on 15/7/15.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PCommunication.h"
@interface TcpSwitchControl : NSObject<PCommunicaion>
{
    
}


-(instancetype)initWithTcpSocket:(GCDAsyncSocket*)tcpSockt;
@property(nonatomic,strong)GCDAsyncSocket*tcpSocket;

@property(nonatomic,strong)NSString*powerOnCommand;
@property(nonatomic,strong)NSString*powerOffCommand;;

@end
