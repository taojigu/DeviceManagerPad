//
//  MasterViewController.h
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/7.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;
@class AsyncUdpSocketController;


@class GCDAsyncUdpSocket;

@interface MasterViewController : UITableViewController


@property (strong, nonatomic) DetailViewController *detailViewController;
@property(nonatomic,strong)AsyncUdpSocketController*socketController;

@end

