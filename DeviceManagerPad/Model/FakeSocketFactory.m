//
//  FakeSocketFactory.m
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/21.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import "FakeSocketFactory.h"

@implementation FakeSocketFactory

+(NSArray*)fakeSocketStringArray{
    
    NSMutableArray*resultArray=[[NSMutableArray alloc]init];
    [resultArray addObject:@"E0"];
    [resultArray addObject:@"D1"];
    [resultArray addObject:@"C2"];
    [resultArray addObject:@"B3"];
    return resultArray;
    
}

@end
