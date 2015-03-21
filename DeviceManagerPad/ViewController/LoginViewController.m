//
//  LoginViewController.m
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/8.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import "LoginViewController.h"
#import "GlobalNotification.h"

@interface LoginViewController (){
    @private
    IBOutlet UITextField*tfUserName;
    IBOutlet UITextField*tfPassword;
    
    
}

-(IBAction)loginButtonClicked:(id)sender;
-(IBAction)refill:(id)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)loginButtonClicked:(id)sender{
    [self login];
}
-(IBAction)refill:(id)sender{
 
    tfUserName.text=nil;
    tfPassword.text=nil;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -- private messages

-(void)login{

    [UIView animateWithDuration:0.5 animations:^{
        CGAffineTransform transform=CGAffineTransformScale(self.view.transform, 10, 10);
        self.view.transform=transform;
        self.view.alpha=0;
        
    } completion:^(BOOL finished) {
           [[NSNotificationCenter defaultCenter]postNotificationName:LoginSuccessNotificationName object:nil];
    }];
 
}

@end
