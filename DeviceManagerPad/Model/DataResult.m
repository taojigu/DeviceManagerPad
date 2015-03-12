//
//  DataResult.m
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/8.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import "DataResult.h"

@implementation DataResult

@synthesize elementArray;


-(instancetype)init{
    self=[super init];
    self.elementArray=[NSMutableArray new];
    return self;
}

@end
