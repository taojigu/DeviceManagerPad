//
//  RemoteDevice.h
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/15.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


//static NSString* const DeviceTypeCluster=@"DeviceTypeCluster";
//static NSString* const DeviceTypeSoftware=@"DeviceTypeSoftware";
//static NSString* const DeviceTypeProjection=@"DeviceTypeProjection";


typedef NS_ENUM(NSInteger, DeviceType) {
    DeviceTypeCluster=1,
    DeviceTypeSoftware=2,
    DeviceTypeProjection=3,
    DeviceTypeAll=4,
    DeviceTypeStereo=5
};


static NSString*const DeviceCommandTypePowerOn=@"PowerOn";
static NSString*const DeviceCommandTypePowerOff=@"PowerOff";
static NSString*const DeviceCommandTypePowerOnAll=@"PowerOnAll";
static NSString*const DeviceCommandTypePowerOfAll=@"PowerOffAll";
static NSString*const DeviceCommandTypeLogin=@"Login";



@interface RemoteDevice : NSManagedObject

@property (nonatomic, retain) NSString * deviceIP;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * port;
@property (nonatomic, retain) NSNumber* type;

@end
