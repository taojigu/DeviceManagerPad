//
//  DeviceDetailViewController.h
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/15.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RemoteDevice.h"
@class DeviceDetailViewController;



typedef NS_ENUM(NSInteger, DetailType){
    DetailTypeAdd=0,
    DetailTypeEdit=1
};




@protocol DeviceDetailViewControllerDelegate <NSObject>


-(void)remoteDeviceDidUpdated:(DeviceDetailViewController*)viewConroller remotedDevice:(RemoteDevice*)remoteDevice;
-(void)remoteDeviceEditCanceled:(DeviceDetailViewController*)viewController;

@end

@interface DeviceDetailViewController : UIViewController{
    
}

@property(nonatomic,strong)RemoteDevice*remoteDevice;
@property(nonatomic,assign)id<DeviceDetailViewControllerDelegate>delegate;
@property(nonatomic,assign)DetailType detailType;
@property(nonatomic,assign)DeviceType deviceType;
@end
