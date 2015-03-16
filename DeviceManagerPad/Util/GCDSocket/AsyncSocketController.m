//
//  AsyncSocketController.m
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/12.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import "AsyncSocketController.h"
#import "Device.h"
#import "GCDAsyncSocket.h"

@implementation AsyncSocketController

-(instancetype)initWithSocket:(GCDAsyncSocket*)socket device:(Device*)device{
    self=[super init];
    return self;
}


-(void)powerOnAll{
    
}
-(void)powerOffAll{
    
}


@end
