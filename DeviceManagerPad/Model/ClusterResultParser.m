//
//  ClusterResultParser.m
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/8.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import "ClusterResultParser.h"
#import "DataResult.h"
#import "Cluster.h"

@implementation ClusterResultParser

-(DataResult*)parse:(NSData*)data{
    DataResult*result=[[DataResult alloc]init];
    for (NSInteger indx=0; indx<5; indx++) {
     
        Cluster*clst=[[Cluster alloc]init];
        clst.clusterID=[NSString stringWithFormat:@"ClustID%li",(long)indx];
        clst.name=[NSString stringWithFormat:@"软件集群%li",(long)indx];
        [result.elementArray addObject:clst];
    }
    return result;
}

@end
