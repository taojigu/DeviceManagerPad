//
//  SwitchTableViewController.h
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/8.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PCellDataFormatter;

@interface SwitchTableViewController : UITableViewController{
    
}

@property(nonatomic,strong)NSString*urlString;
@property(nonatomic,strong)id<PCellDataFormatter>cellDataFormatter;

@end
