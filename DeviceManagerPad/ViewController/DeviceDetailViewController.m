//
//  DeviceDetailViewController.m
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/15.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import "DeviceDetailViewController.h"


#import "RemoteDevice.h"
#import "CoreDateTypeUtility.h"

@interface DeviceDetailViewController (){
    @private
    
}

@property(nonatomic,strong)IBOutlet UITextField*deviceNameTextField;
@property(nonatomic,strong) IBOutlet UITextField*portTextField;
@property(nonatomic,strong) IBOutlet UITextField*ipTextField;

@end

@implementation DeviceDetailViewController

@synthesize remoteDevice;
@synthesize delegate;
@synthesize detailType;
@synthesize deviceType;

@synthesize deviceNameTextField;
@synthesize portTextField;
@synthesize ipTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initViewValues];
    [self refresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -- selctor messages

-(IBAction)doneClicked:(id)sender{
    [self finishEdit];
}
-(IBAction)cancelButtonClicked:(id)sender{
    
    if (self.delegate!=nil&&[self.delegate respondsToSelector:@selector(remoteDeviceEditCanceled:)]) {
        [self.delegate remoteDeviceEditCanceled:self];
    }
    
}
#pragma mark -- private messages


-(void)refresh{
    self.deviceNameTextField.text=self.remoteDevice.name;
    self.ipTextField.text=self.remoteDevice.deviceIP;
    self.title=[CoreDateTypeUtility titleForDeviceType:self.deviceType];
}

-(void)finishEdit{
    self.remoteDevice.type=[NSNumber numberWithInteger:self.deviceType];
    self.remoteDevice.name=self.deviceNameTextField.text;
    self.remoteDevice.deviceIP=self.ipTextField.text;
    self.remoteDevice.port=[NSNumber numberWithInteger:[self.portTextField.text intValue]];

    if (self.delegate!=nil&&[self.delegate respondsToSelector:@selector(remoteDeviceDidUpdated:remotedDevice:)]) {
        
        [self.delegate remoteDeviceDidUpdated:self remotedDevice:self.remoteDevice];
    }
    [self.navigationController popViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:YES completion:nil];

}
-(void)initViewValues{
    

    UIBarButtonItem*doneItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
    self.navigationItem.rightBarButtonItem=doneItem;
    
    UIBarButtonItem*cancelItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonClicked:)];
    self.navigationItem.leftBarButtonItem=cancelItem;
    
    
    
    if (self.detailType==DetailTypeEdit) {
        
    }
    else{
        
    }
}

@end
