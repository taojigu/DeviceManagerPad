//
//  ProjectionCellDataFormatter.m
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/8.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import "ProjectionCellDataFormatter.h"
#import "DataResult.h"
#import "ProjectionResultParser.h"
#import "Projection.h"

@interface ProjectionCellDataFormatter ()

@property(nonatomic,strong)DataResult*dataResult;

@end

@implementation ProjectionCellDataFormatter


@synthesize dataResult;
@synthesize shouldReload;

-(NSInteger)numberOfRows:(UITableView*)tableView section:(NSInteger)section{
    return self.dataResult.elementArray.count;
}
-(NSString*)titleForCell:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath{
    Projection*prj=[self.dataResult.elementArray objectAtIndex:indexPath.row];
    return prj.name;
}
-(void)parse:(NSData*)data{
    
    ProjectionResultParser*parser=[[ProjectionResultParser alloc]init];
    self.dataResult=[parser parse:data];
    
}

@end
