//
//  TcpSwitchControl.h
//  DeviceManagerPad
//
//  Created by gus on 15/7/15.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PCommunication.h"
@class RemoteDevice;

@interface TcpSwitchControl : NSObject
{
    
}

@property(nonatomic,strong)RemoteDevice*device;

-(instancetype)initWithDevice:(RemoteDevice*)device;
-(void)connectAndPowerOn:(RemoteDevice*)device;
-(void)powerOnDevice:(RemoteDevice*)device;

@property(nonatomic,strong)NSString*powerOnCommand;
@property(nonatomic,strong)NSString*quickShotCommand;
@property(nonatomic,strong)NSString*powerOffCommand;;




@end
