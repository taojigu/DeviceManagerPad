//
//  ClusterResultParser.h
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/8.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DataResult;

@interface ClusterResultParser : NSObject


-(DataResult*)parse:(NSData*)data;
@end
