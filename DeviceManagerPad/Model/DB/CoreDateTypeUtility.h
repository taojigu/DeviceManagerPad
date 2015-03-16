//
//  CoreDateTypeUtility.h
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/16.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RemoteDevice.h"



@interface DeviceTypeItem:NSObject{
    
}

@property(nonatomic,assign)DeviceType deviceTpye;
@property(nonatomic,assign)NSString*deviceTypeTitle;

@end






@interface CoreDateTypeUtility : NSObject


+(NSArray*)deviceTypeItemArray;
+(NSArray*)deviceTitleArray;
+(DeviceType)deviceTypeOfTitle:(NSString*)title;
+(NSString*)titleForDeviceType:(DeviceType)deviceType;

@end
