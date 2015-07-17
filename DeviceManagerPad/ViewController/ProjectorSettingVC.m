//
//  ProjectorSettingVC.m
//  DeviceManagerPad
//
//  Created by gus on 15/7/17.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import "ProjectorSettingVC.h"
#import "DeviceCommunication.h"

@interface ProjectorSettingVC ()
{
    
}

@property(nonatomic,strong)IBOutlet UITextField*quickShotTextField;
@property(nonatomic,strong)IBOutlet UITextField*powerOnTextField;
@property(nonatomic,strong)IBOutlet UITextField*powerOffTextField;

@end

@implementation ProjectorSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self refresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)saveButtonClicked:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setObject:self.quickShotTextField.text   forKey:ProjectionQuickShotKey];
    [[NSUserDefaults standardUserDefaults] setObject:self.powerOnTextField.text forKey:ProjectionPowerOnKey];
    [[NSUserDefaults standardUserDefaults] setObject:self.powerOffTextField.text forKey:ProjectionPowerOffKey];
    
}

-(void)refresh
{
    self.quickShotTextField.text=[[NSUserDefaults standardUserDefaults]objectForKey:ProjectionQuickShotKey];
    self.powerOnTextField.text=[[NSUserDefaults standardUserDefaults]objectForKey:ProjectionPowerOnKey];
    self.powerOffTextField.text=[[NSUserDefaults standardUserDefaults]objectForKey:ProjectionPowerOffKey];
    
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
