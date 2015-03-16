//
//  AsyncSocketController.h
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/12.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GCDAsyncSocket;
@class Device;

@interface AsyncSocketController : NSObject



-(instancetype)initWithSocket:(GCDAsyncSocket*)socket device:(Device*)device;

-(void)powerOnAll;
-(void)powerOffAll;

@end
