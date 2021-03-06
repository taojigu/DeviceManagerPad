//
//  SwitchTableViewController.h
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/8.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RemoteDevice.h"
#import "PCommunication.h"



@interface SwitchTableViewController : UITableViewController{
    
}


@property(nonatomic,assign)DeviceType deviceType;
@property(nonatomic,strong)id<PCommunicaion>communication;
@property(nonatomic,assign)BOOL editable;

@property(nonatomic,strong)DeviceCommnadBlock comandBlock;


@end
