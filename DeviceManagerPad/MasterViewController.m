//
//  MasterViewController.m
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/7.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "TestViewController.h"
#import "SwitchTableViewController.h"
#import "StartViewController.h"
#import "AsyncUdpSocketController.h"
#import "MainCommandControl.h"
#import "StereoCommandControl.h"
#import "StereoCommandControl.h"
#import "UserManagement.h"

#import "CoreDataAdaptor.h"
#import "CoreDateTypeUtility.h"
#import "GCDAsyncUdpSocket.h"
#import "SwitchCommandControl.h"
#import "DeviceCommunication.h"
#import "SwitchSocketSettingController.h"
#import "StereoSocketSettingViewController.h"

#define StartSection 0
#define ManagementSection 1
#define LogSetion 2
#define SettingSection 3

#define ClusterRow 0
#define ProjectionRow 1
#define StereoRow 2
#define SoftwareRow 3


@interface MasterViewController ()


@end

@implementation MasterViewController

@synthesize socketController;

- (void)awakeFromNib {
    [super awakeFromNib];
    self.clearsSelectionOnViewWillAppear = NO;
    self.preferredContentSize = CGSizeMake(320.0, 600.0);
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.socketController=[[AsyncUdpSocketController alloc]init];

    [[CoreDataAdaptor instance] saveCurrentChanges:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Segues

- (void)processManagementSegue:(UIStoryboardSegue *)segue indexPath:(NSIndexPath *)indexPath {
    NSString*loginUserName=[[NSUserDefaults standardUserDefaults]objectForKey:LoginUserNameKey];
    NSAssert(loginUserName.length>0, @"no login user");
    NSUserDefaults*defaultSetting=[NSUserDefaults standardUserDefaults];
    BOOL editable=[loginUserName isEqualToString:AdminUserName];
    UINavigationController*navi=(UINavigationController*)segue.destinationViewController;
    if (1==indexPath.section&&0==indexPath.row) {
        SwitchTableViewController*stvc=(SwitchTableViewController*)navi.topViewController;
        stvc.deviceType=DeviceTypeCluster;
        stvc.title=[CoreDateTypeUtility titleForDeviceType:stvc.deviceType];
        stvc.editable=editable;
        SwitchCommandControl*swtcc=[[SwitchCommandControl alloc]initWithUdpSocket:self.socketController.udpSocket];
        swtcc.powerOnCommand=[defaultSetting objectForKey:ClusterPowerOnKey];
        swtcc.powerOffCommand=[defaultSetting objectForKey:ClusterPowerOffKey];
        stvc.communication=swtcc;
        return;
    }
    if (1==indexPath.section&&1==indexPath.row) {
        SwitchTableViewController*stvc=(SwitchTableViewController*)navi.topViewController;
        stvc.deviceType=DeviceTypeProjection;
        stvc.title=[CoreDateTypeUtility titleForDeviceType:stvc.deviceType];
        stvc.editable=editable;
        SwitchCommandControl*swtcc=[[SwitchCommandControl alloc]initWithUdpSocket:self.socketController.udpSocket];
        swtcc.powerOnCommand=[defaultSetting objectForKey:ProjectionPowerOnKey];
        swtcc.powerOffCommand=[defaultSetting objectForKey:ProjectionPowerOffKey];
        stvc.communication=swtcc;
        return;
    }
    if (1==indexPath.section&&3==indexPath.row) {
        SwitchTableViewController*stvc=(SwitchTableViewController*)navi.topViewController;
        stvc.deviceType=DeviceTypeSoftware;
        stvc.title=[CoreDateTypeUtility titleForDeviceType:stvc.deviceType];
       
        stvc.editable=editable;
        SwitchCommandControl*swtcc=[[SwitchCommandControl alloc]initWithUdpSocket:self.socketController.udpSocket];
        swtcc.powerOnCommand=[defaultSetting objectForKey:ProjectionPowerOnKey];
        swtcc.powerOffCommand=[defaultSetting objectForKey:ProjectionPowerOffKey];
        stvc.communication=swtcc;
        return;
    }
    if (0==indexPath.section) {
        
        //StartViewController*stvc=(StartViewController*)navi.topViewController;
        
        return;
    }
}
-(void)processSettingSegue:(UIStoryboardSegue *)segue indexPath:(NSIndexPath*)indexPath{
    UINavigationController*navi=(UINavigationController*)segue.destinationViewController;
    navi.topViewController.title=[self titleForIndexPath:indexPath];
    if ([navi.topViewController class]==[SwitchSocketSettingController class]) {
        SwitchSocketSettingController*sssvc=(SwitchSocketSettingController*)navi.topViewController;
        if (ClusterRow==indexPath.row) {
            sssvc.powerOnCommandKey=ClusterPowerOnKey;
            sssvc.powerOffCommandKey=ClusterPowerOffKey;
            
            return;
        }
        if (ProjectionRow==indexPath.row) {
            sssvc.powerOnCommandKey=ProjectionPowerOnKey;
            sssvc.powerOffCommandKey=ProjectionPowerOffKey;
            return;
        }
        if (SoftwareRow==indexPath.row) {
            sssvc.powerOnCommandKey=SoftwarePowerOnKey;
            sssvc.powerOffCommandKey=SoftwarePowerOffKey;
        }
        return;
    }
    if ([navi.topViewController class]==[StereoSocketSettingViewController class]) {
        
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath*indexPath=[self.tableView indexPathForSelectedRow];
    if (indexPath.section==ManagementSection) {
        [self processManagementSegue:segue indexPath:indexPath];
        return;
    }
    if (indexPath.section==SettingSection) {
        [self processSettingSegue:segue indexPath:indexPath];
    }
    
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (0==section||2==section) {
        return 1;
    }else{
        return 4;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (SettingSection==indexPath.section) {
        return [self socketSettincCell:tableView indexPath:indexPath];
    }
    
    NSString*cellIdentifer=[self cellIdentifer:indexPath];
    NSAssert(cellIdentifer.length>0, @"CellIdentifer should not be nil");
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer forIndexPath:indexPath];

   
    return cell;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (1==section) {
        return @"管理";
    }
    
    return nil;
    
}




#pragma mark -- privte messages

-(UITableViewCell*)socketSettincCell:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath{
    
    switch (indexPath.row) {
        case ClusterRow:
        case ProjectionRow:
        case SoftwareRow:
            return [self switchSocketSettingCell:tableView indexPath:indexPath];
        case StereoRow:
            return [self stereoSocketSettingCell:tableView indexPath:indexPath];
        default:
            break;
    }
    
    
    
    
    
    return nil;
}

-(UITableViewCell*)switchSocketSettingCell:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath{
    static NSString*switchSocketSettingCell=@"SwitchSocketSettingCell";
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:switchSocketSettingCell forIndexPath:indexPath];
    switch (indexPath.row) {
        case ClusterRow:
            cell.textLabel.text=@"ClusterSetting";
            break;
        case ProjectionRow:
            cell.textLabel.text=@"ProjectionSetting";
            break;
        case SoftwareRow:
            cell.textLabel.text=@"SoftwareSetting";
            break;
        default:
            cell.textLabel.text=@"UnknownSetting";
            break;
    }
    return cell;
}
-(UITableViewCell*)stereoSocketSettingCell:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath{
    static NSString*settingCell=@"StereoSocketSettingCell";
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:settingCell forIndexPath:indexPath];
    cell.textLabel.text=@"音响设置";
    return cell;
}
-(NSString*)titleForIndexPath:(NSIndexPath*)indexPath{
    if (indexPath.section!=SettingSection&&indexPath.section!=ManagementSection) {
        return nil;
    }
    switch (indexPath.row) {
        case ClusterRow:
            return @"Cluster";
        case ProjectionRow:
            return @"Project";
        case StereoRow:
            return @"Stereo";
        case SoftwareRow:
            return @"Software";
        default:
            break;
    }
    return nil;
}
-(NSString*)cellIdentifer:(NSIndexPath*)indexPath{
    
    if (0==indexPath.section) {
        return @"StartCell";
    }
    if (2==indexPath.section) {
        return @"LogCell";
    }
    if (1==indexPath.section) {
        switch (indexPath.row) {
            case 0:
                return @"ClusterCell";
            case 1:
                return @"ProjectionCell";
            case 2:
                return @"StereoCell";
            case 3:
                return @"SoftwareCell";
                
                
            default:
                return nil;
        }
    }
    return nil;
    
}

@end
