//
//  AsyncSocketController.h
//  DeviceManagerPad
//
//  Created by gus on 15/7/15.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"

@interface AsyncSocketController : NSObject


@property(nonatomic,strong)GCDAsyncSocket* tcpSocket;

@end
