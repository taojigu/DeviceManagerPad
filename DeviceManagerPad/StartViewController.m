//
//  StartViewController.m
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/8.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import "StartViewController.h"
#import "AsyncSocketController.h"


@interface StartViewController ()

@end

@implementation StartViewController

@synthesize socketController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)powerOn:(id)sender{
    
    [self.socketController powerOnAll];
}
-(IBAction)powerOff:(id)sender{
    [self.socketController powerOffAll];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end