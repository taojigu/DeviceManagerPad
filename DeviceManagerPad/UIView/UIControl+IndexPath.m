//
//  UIControl+IndexPath.m
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/15.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import "UIControl+IndexPath.h"
#import <objc/runtime.h>

#define PropertyKeyIndexPath "PropertyKeyIndexPath"

@implementation UIControl(IndexPath)


-(NSIndexPath*)indexPath{
   return  objc_getAssociatedObject(self, PropertyKeyIndexPath);
}

-(void)setIndexPath:(NSIndexPath *)indexPath{
    objc_setAssociatedObject(self, PropertyKeyIndexPath, indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
