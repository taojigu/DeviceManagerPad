//
//  ProjectionResultParser.h
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/8.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

@class DataResult;
#import <Foundation/Foundation.h>


@interface ProjectionResultParser : NSObject


-(DataResult*)parse:(NSData*)data;

@end
