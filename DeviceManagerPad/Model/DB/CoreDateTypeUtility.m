//
//  CoreDateTypeUtility.m
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/16.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import "CoreDateTypeUtility.h"


@implementation DeviceTypeItem

@synthesize deviceTpye;
@synthesize deviceTypeTitle;

@end



@implementation CoreDateTypeUtility

+(NSArray*)deviceTypeItemArray{
    static NSMutableArray*itemArray=nil;
    if(itemArray==nil){
        itemArray=[[NSMutableArray alloc]init];
        DeviceTypeItem*item1=[[DeviceTypeItem alloc]init];
        item1.deviceTpye=DeviceTypeCluster;
        item1.deviceTypeTitle=@"集群";
        [itemArray addObject:item1];
        
        DeviceTypeItem*item2=[[DeviceTypeItem alloc]init];
        item2.deviceTpye=DeviceTypeProjection;
        item2.deviceTypeTitle=@"投影";
        [itemArray addObject:item2];
        
        DeviceTypeItem*item3=[[DeviceTypeItem alloc]init];
        item3.deviceTpye=DeviceTypeSoftware;
        item3.deviceTypeTitle=@"软件";
        [itemArray addObject:item3];
        
        DeviceTypeItem*item4=[[DeviceTypeItem alloc]init];
        item4.deviceTpye=DeviceTypeAll;
        item4.deviceTypeTitle=@"所有类型设备";
    }
    return itemArray;
}
+(NSArray*)deviceTitleArray{
    NSMutableArray*titleArray=[[NSMutableArray alloc]init];
    NSArray*itemArray=[CoreDateTypeUtility deviceTypeItemArray];
    [itemArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        DeviceTypeItem*item=(DeviceTypeItem*)obj;
        [titleArray addObject:item.deviceTypeTitle];
    }];
    return titleArray;
}

+(DeviceType)deviceTypeOfTitle:(NSString*)title{
    
    NSArray*itemArray=[CoreDateTypeUtility deviceTitleArray];
    for (DeviceTypeItem*item in itemArray) {
        if ([title isEqualToString:item.deviceTypeTitle]) {
            return item.deviceTpye;
        }
    }
    
    NSAssert(NO, @"Invalidate DeviceType");
    return -1;
}

+(NSString*)titleForDeviceType:(DeviceType)deviceType{
    NSArray*itemArray=[CoreDateTypeUtility deviceTypeItemArray];
    for (DeviceTypeItem*item in itemArray) {
        if (deviceType==item.deviceTpye) {
            return item.deviceTypeTitle;
        }
    }
    
    NSAssert(NO, @"Invalidate DeviceTypeTitle");
    return nil;
}



@end
