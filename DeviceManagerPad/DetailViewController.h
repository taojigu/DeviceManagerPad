//
//  DetailViewController.h
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/7.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

