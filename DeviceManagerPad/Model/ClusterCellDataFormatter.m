//
//  ClusterCellDataFormatter.m
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/8.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import "ClusterCellDataFormatter.h"
#import "DataResult.h"
#import "ClusterResultParser.h"
#import "Cluster.h"
#import <UIKit/UIKit.h>

@interface ClusterCellDataFormatter ()

@property(nonatomic,strong)DataResult*dataResult;

@end;


@implementation ClusterCellDataFormatter

@synthesize dataResult;
@synthesize shouldReload;

-(NSInteger)numberOfRows:(UITableView*)tableView section:(NSInteger)section{
    return self.dataResult.elementArray.count;
}
-(NSString*)titleForCell:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath{
    Cluster*clst=[self.dataResult.elementArray objectAtIndex:indexPath.row];
    return clst.name;
}
-(void)parse:(NSData*)data{
    
    ClusterResultParser*parser=[[ClusterResultParser alloc]init];
    self.dataResult=[parser parse:data];
    
}


@end
