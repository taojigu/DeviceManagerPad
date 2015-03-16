//
//  Device.h
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/12.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Device : NSObject{
    
}

@property(nonatomic,strong)NSString*name;
@property(nonatomic,strong)NSString*IP;
@property(nonatomic,strong)NSString*macAddress;
@property(nonatomic,strong)NSString*type;

+(Device*)fakeDevice;

@end
