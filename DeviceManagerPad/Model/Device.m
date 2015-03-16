//
//  Device.m
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/12.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import "Device.h"

@implementation Device{
    
}

@synthesize name;
@synthesize type;
@synthesize macAddress;
@synthesize IP;


+(Device*)fakeDevice{
    Device*dvc=[[Device alloc]init];
    dvc.name=@"Device";
    dvc.IP=@"192.168.1.1";
    dvc.macAddress=@"08:07:32";
    dvc.type=@"DeviceType";
    return dvc;
}

@end
