//
//  ProjectionCommandControl.h
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/17.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PCommunication.h"

@interface ProjectionCommandControl : NSObject<PCommunicaion>

@property(nonatomic,strong)GCDAsyncUdpSocket*udpSocket;

@end
