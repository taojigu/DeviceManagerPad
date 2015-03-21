//
//  OperationLog.m
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/15.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import "OperationLog.h"
#import "RemoteDevice.h"


@implementation OperationLog

@dynamic commandType;
@dynamic commandText;
@dynamic user;
@dynamic dateTime;
@dynamic deviceIP;
@dynamic deviceName;
@dynamic deviceType;


-(NSString*)operationDecription{
    
    NSMutableString*result=[[NSMutableString alloc]init];
    [result appendFormat:@"[%@]",self.dateTime];
    [result appendFormat:@" %@:",self.user];
    if ([self.commandType isEqualToString:DeviceCommandTypePowerOnAll]||[self.commandType isEqualToString:DeviceCommandTypePowerOfAll]) {
        [result appendFormat:@" %@",self.commandText];
    }
    else{
        [result appendFormat:@" Send %@ to %@(%@)",self.commandType,self.deviceName,self.deviceIP];
    }
    
    return result;
    
}



@end
