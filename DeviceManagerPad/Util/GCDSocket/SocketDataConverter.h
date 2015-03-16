//
//  SocketDataConverter.h
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/13.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SocketDataConverter : NSObject



+(char*)bytesFromNSString:(NSString*)str;

+(int)commandValueForNSString:(NSString*)command;


@end
