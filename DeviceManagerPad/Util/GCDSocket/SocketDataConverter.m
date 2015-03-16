//
//  SocketDataConverter.m
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/13.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import "SocketDataConverter.h"

@implementation SocketDataConverter

+(char*)bytesFromNSString:(NSString*)str{
   
    return [str UTF8String];
}

@end
