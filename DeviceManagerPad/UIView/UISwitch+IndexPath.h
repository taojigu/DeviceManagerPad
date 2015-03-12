//
//  UISwitch+IndexPath.h
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/8.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


static NSString* const PropertyKeyIndexPath=@"PropertyKeyIndexPath";

@interface UISwitch(IndexPath)

@property(nonatomic,strong)NSIndexPath*indexPath;
@end
