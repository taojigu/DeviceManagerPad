//
//  SwitchCommandControl.h
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/21.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PCommunication.h"

@interface SwitchCommandControl : NSObject<PCommunicaion>{
    
}

-(instancetype)initWithUdpSocket:(GCDAsyncUdpSocket*)socket;


@property(nonatomic,strong)NSString*powerOnCommand;
@property(nonatomic,strong)NSString*powerOffCommand;

@end
