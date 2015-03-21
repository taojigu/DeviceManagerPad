//
//  StartViewController.m
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/8.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import "StartViewController.h"
#import "AsyncUdpSocketController.h"

#import "CoreDataAdaptor.h"


@interface StartViewController ()

@end

@implementation StartViewController


@synthesize communication;
@synthesize editable;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)powerOn:(id)sender{
    
    [self.communication sendPowerOn:nil port:0];
    

    

}
-(IBAction)powerOff:(id)sender{
    [self.communication sendPowerOff:nil port:0];
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
