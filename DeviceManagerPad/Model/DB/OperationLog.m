//
//  OperationLog.m
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/15.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import "OperationLog.h"


@implementation OperationLog

@dynamic command;
@dynamic user;
@dynamic dateTime;
@dynamic deviceIP;
@dynamic deviceName;
@dynamic deviceType;


-(NSString*)operationDecription{
    
    NSMutableString*result=[[NSMutableString alloc]init];
    [result appendFormat:@"[%@]",self.dateTime];
    [result appendFormat:@" %@:",self.user];
    [result appendFormat:@" 向%@(%@) send %@",self.deviceName,self.deviceIP,self.command];
    return result;
    
}



@end
