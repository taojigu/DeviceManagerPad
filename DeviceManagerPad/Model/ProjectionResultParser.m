//
//  ProjectionResultParser.m
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/8.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import "ProjectionResultParser.h"

#import "DataResult.h"
#import "Projection.h"
#import "ProjectionResultParser.h"

@implementation ProjectionResultParser

-(DataResult*)parse:(NSData*)data{
    DataResult*result=[[DataResult alloc]init];
    for (NSInteger indx=0; indx<5; indx++) {
        
        Projection*prjt=[[Projection alloc]init];
        prjt.projectionID=[NSString stringWithFormat:@"ProjectionID%li",(long)indx];
        prjt.name=[NSString stringWithFormat:@"投影名称%li",(long)indx];
        [result.elementArray addObject:prjt];
    }
    return result;
}


@end
