//
//  StereoViewController.h
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/18.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCommunication.h"

@interface StereoViewController : UIViewController

@property(nonatomic,strong)id<PCommunicaion>communication;
@property(nonatomic,assign)BOOL editable;

@end
