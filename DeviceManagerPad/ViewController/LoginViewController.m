//
//  LoginViewController.m
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/8.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import "LoginViewController.h"
#import "GlobalNotification.h"
#import "UserManagement.h"

@interface LoginViewController (){
    @private
    IBOutlet UITextField*tfUserName;
    IBOutlet UITextField*tfPassword;
    IBOutlet UIButton* loginButton;
    IBOutlet UIButton* refillButton;
    
    
}

-(IBAction)loginButtonClicked:(id)sender;
-(IBAction)refill:(id)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initFieldViewValues];
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
    
    if ([self isAuthenticated]) {
        [UIView animateWithDuration:0.5 animations:^{
            CGAffineTransform transform=CGAffineTransformScale(self.view.transform, 10, 10);
            self.view.transform=transform;
            self.view.alpha=0;
            
        } completion:^(BOOL finished) {
            [[NSNotificationCenter defaultCenter]postNotificationName:LoginSuccessNotificationName object:nil];
        }];
        
        [[NSUserDefaults standardUserDefaults] setObject:tfUserName.text forKey:LoginUserNameKey];
        [[NSUserDefaults standardUserDefaults] setObject:tfPassword.text forKey:LoginUserPasswordKey];
    }

}

-(void)initFieldViewValues{
    NSString*userName=[[NSUserDefaults standardUserDefaults] objectForKey:LoginUserNameKey];
    if (0!=userName.length) {
        tfUserName.text=userName;
        tfPassword.text=[[NSUserDefaults standardUserDefaults] objectForKey:LoginUserPasswordKey];
    }
    
    UIImage* backgroundImage = [UIImage imageNamed:@"LoginBackground"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    
    [loginButton setBackgroundColor:[UIColor whiteColor]];
    loginButton.layer.cornerRadius = 8;
    [refillButton setBackgroundColor:[UIColor whiteColor]];
    refillButton.layer.cornerRadius = 8;
    
    return;
}

-(BOOL)isAuthenticated{
    if ([[tfUserName.text uppercaseString] isEqualToString:[AdminUserName uppercaseString]]) {
        if ([tfPassword.text isEqualToString:AdminPassword]) {
            return YES;
        }
    }
    if ([[tfUserName.text uppercaseString] isEqualToString:[UserUserName uppercaseString]]) {
        if ([tfPassword.text isEqualToString:UserPassword]) {
            return YES;
        }
    }
    return NO;
    
}

@end
