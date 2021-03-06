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

#import "UserManagement.h"

#import "CoreDataAdaptor.h"
#import "CoreDateTypeUtility.h"
#import "GCDAsyncUdpSocket.h"
#import "SwitchCommandControl.h"
#import "DeviceCommunication.h"
#import "SwitchSocketSettingController.h"


#import "AsyncSocketController.h"
#import "TcpSwitchControl.h"
#import "ProjectDeviceTVC.h"


#define StartSection 0
#define ManagementSection 1
#define LogSetion 2
#define SettingSection 3

#define ClusterRow 0
#define ProjectionRow 1
//#define StereoRow 2
//#define SoftwareRow 3


@interface MasterViewController (){
    
}

@property(nonatomic,strong)NSMutableArray*projectSocketControlArray;


//@property(nonatomic,strong)GCDAsyncSocket*tcpSocket;


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
    self.tcpSocketController =[[AsyncSocketController alloc]init];
    
    self.projectSocketControlArray = [NSMutableArray array];
    

    [[CoreDataAdaptor instance] saveCurrentChanges:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Segues


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath*indexPath=[self.tableView indexPathForSelectedRow];
    if (indexPath.section==ManagementSection) {
        [self processManagementSegue:segue indexPath:indexPath];
        return;
    }
    if (indexPath.section==SettingSection) {
        [self processSettingSegue:segue indexPath:indexPath];
    }
    if (indexPath.section==StartSection) {
        [self processStartSegue:segue];
    }
    
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSString*loginUserName=[[NSUserDefaults standardUserDefaults]objectForKey:LoginUserNameKey];
    BOOL editable=[loginUserName isEqualToString:AdminUserName];
    if (editable)
    {
        return 4;
    }
    else
    {
        return 3;
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (0==section||2==section) {
        return 1;
    }else{
        return 2;
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

-(void)processStartSegue:(UIStoryboardSegue*)segue{
    UINavigationController*navi=(UINavigationController*)segue.destinationViewController;
    StartViewController*startvc=(StartViewController*)navi.topViewController;
    startvc.communication=[[MainCommandControl alloc]initWithUdpSocket:self.socketController.udpSocket];
    
}
- (void)processClusterSwitchViewController:(UINavigationController *)navi editable:(BOOL)editable defaultSetting:(NSUserDefaults *)defaultSetting {
    SwitchTableViewController*stvc=(SwitchTableViewController*)navi.topViewController;
    stvc.deviceType=DeviceTypeCluster;
    stvc.title=[CoreDateTypeUtility titleForDeviceType:stvc.deviceType];
    stvc.editable=editable;
    SwitchCommandControl*swtcc=[[SwitchCommandControl alloc]initWithUdpSocket:self.socketController.udpSocket];
    
    swtcc.repeatTime = [self clusterRepeatTime];
    //swtcc.powerOnCommand=[defaultSetting objectForKey:ClusterPowerOnKey];
    //swtcc.powerOffCommand=[defaultSetting objectForKey:ClusterPowerOffKey];
    stvc.communication=swtcc;
    return;
    
}


-(NSInteger)clusterRepeatTime
{
    NSInteger repTime = [[NSUserDefaults standardUserDefaults] integerForKey:ClusterRepeatTimeKey];
    if(repTime<=0)
    {
        repTime =3;
    }
    
    return repTime;
    
}

- (void)processProjectSwitchViewController:(UINavigationController *)navi editable:(BOOL)editable defaultSetting:(NSUserDefaults *)defaultSetting {
    SwitchTableViewController*stvc=(SwitchTableViewController*)navi.topViewController;
    stvc.deviceType=DeviceTypeProjection;
    stvc.title=[CoreDateTypeUtility titleForDeviceType:stvc.deviceType];
    stvc.editable=editable;
    


    SwitchCommandControl*swtcc=[[SwitchCommandControl alloc]initWithUdpSocket:self.socketController.udpSocket];
    swtcc.powerOnCommand=[defaultSetting objectForKey:ProjectionPowerOnKey];
    swtcc.powerOffCommand=[defaultSetting objectForKey:ProjectionPowerOffKey];
    stvc.communication=swtcc;
}

- (void)processSoftwareSwitchViewController:(UINavigationController *)navi editable:(BOOL)editable defaultSetting:(NSUserDefaults *)defaultSetting {
    SwitchTableViewController*stvc=(SwitchTableViewController*)navi.topViewController;
    stvc.deviceType=DeviceTypeSoftware;
    stvc.title=[CoreDateTypeUtility titleForDeviceType:stvc.deviceType];
    
    stvc.editable=editable;
    SwitchCommandControl*swtcc=[[SwitchCommandControl alloc]initWithUdpSocket:self.socketController.udpSocket];
    swtcc.powerOnCommand=[defaultSetting objectForKey:SoftwarePowerOnKey];
    swtcc.powerOffCommand=[defaultSetting objectForKey:SoftwarePowerOffKey];
    stvc.communication=swtcc;
}

-(void)processPrjectDeviceVC:(UINavigationController *)navi editable:(BOOL)editable defaultSetting:(NSUserDefaults *)defaultSetting
{
    

    SwitchTableViewController*stvc=(SwitchTableViewController*)navi.topViewController;
    stvc.deviceType=DeviceTypeProjection;
    stvc.title=[CoreDateTypeUtility titleForDeviceType:stvc.deviceType];
    stvc.editable=editable;
    __weak MasterViewController*weakSelf = (MasterViewController*)self;
    stvc.comandBlock=^(id sender,NSString*cmdString,RemoteDevice* device)
    {
        [weakSelf processCommand:sender command:cmdString device:device];
    };

    
}


-(void)processCommand:(id)sender command:(NSString*)cmdString device:(RemoteDevice*)device
{
    SwitchTableViewController*stvc = (SwitchTableViewController*)sender;
    if (DeviceTypeProjection != stvc.deviceType)
    {
        return;
    }
    if ([cmdString isEqualToString:DeviceCommandTypePowerOn])
    {
        [self powerOnProjector:device];
         return;
    }
    if ([cmdString isEqualToString:DeviceCommandTypePowerOff])
    {
        [self powerOffProjector:device];
    }
    
}

-(void)powerOnProjector:(RemoteDevice*)device
{
    TcpSwitchControl* prjSwitch = [self projectorControl:device];
    if (prjSwitch==nil)
    {
        prjSwitch = [[TcpSwitchControl alloc]initWithDevice:device];
        [prjSwitch checkConnection];
        NSUserDefaults*defalut =[NSUserDefaults standardUserDefaults];
        prjSwitch.powerOffCommand =[defalut stringForKey:ProjectionPowerOffKey];
        prjSwitch.powerOnCommand = [defalut stringForKey:ProjectionPowerOnKey];
        prjSwitch.quickShotCommand = [defalut stringForKey:ProjectionQuickShotKey];
        [self.projectSocketControlArray addObject:prjSwitch];
    }
    
    [prjSwitch powerOnDevice:device];
    
    

}
-(void)powerOffProjector:(RemoteDevice*)device
{
    TcpSwitchControl* prjSwitch = [self projectorControl:device];
    if (prjSwitch==nil)
    {
        prjSwitch = [[TcpSwitchControl alloc]initWithDevice:device];
        [prjSwitch checkConnection];
        NSUserDefaults*defalut =[NSUserDefaults standardUserDefaults];
        prjSwitch.powerOffCommand =[defalut stringForKey:ProjectionPowerOffKey];
        prjSwitch.powerOnCommand = [defalut stringForKey:ProjectionPowerOnKey];
        prjSwitch.quickShotCommand = [defalut stringForKey:ProjectionQuickShotKey];
        [self.projectSocketControlArray addObject:prjSwitch];
    }
   
    [prjSwitch powerOffDevice:device];
    
}

-(TcpSwitchControl*)projectorControl:(RemoteDevice*)device
{
    for (TcpSwitchControl* control in self.projectSocketControlArray)
    {
        if ([control.device.deviceIP isEqualToString:device.deviceIP]&&
            device.port==control.device.port)
        {
            return control;
        }
    }
    return nil;
}

- (void)processManagementSegue:(UIStoryboardSegue *)segue indexPath:(NSIndexPath *)indexPath {
    NSString*loginUserName=[[NSUserDefaults standardUserDefaults]objectForKey:LoginUserNameKey];
    NSAssert(loginUserName.length>0, @"no login user");
    NSUserDefaults*defaultSetting=[NSUserDefaults standardUserDefaults];
    BOOL editable=[loginUserName isEqualToString:AdminUserName];
    UINavigationController*navi=(UINavigationController*)segue.destinationViewController;
    if (ManagementSection==indexPath.section&&ClusterRow==indexPath.row) {
        [self processClusterSwitchViewController:navi editable:editable defaultSetting:defaultSetting];
        return;
    }
    if (ManagementSection==indexPath.section&&ProjectionRow==indexPath.row)
    {
        //[self processProjectSwitchViewController:navi editable:editable defaultSetting:defaultSetting];
        [self processPrjectDeviceVC:navi editable:editable defaultSetting:defaultSetting];
        
        return;
    }

}
-(void)processSettingSegue:(UIStoryboardSegue *)segue indexPath:(NSIndexPath*)indexPath{
    UINavigationController*navi=(UINavigationController*)segue.destinationViewController;
    navi.topViewController.title=[self titleForIndexPath:indexPath];
    if ([navi.topViewController class]==[SwitchSocketSettingController class]) {
        SwitchSocketSettingController*sssvc=(SwitchSocketSettingController*)navi.topViewController;
        if (ClusterRow==indexPath.row) {
            //sssvc.powerOnCommandKey=ClusterPowerOnKey;
            //sssvc.powerOffCommandKey=ClusterPowerOffKey;
            sssvc.repeateTimeKey = ClusterRepeatTimeKey;
            
            return;
        }
        if (ProjectionRow==indexPath.row) {
            sssvc.powerOnCommandKey=ProjectionPowerOnKey;
            sssvc.powerOffCommandKey=ProjectionPowerOffKey;
            return;
        }
               return;
    }
    
}


-(UITableViewCell*)socketSettincCell:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath{
    
    switch (indexPath.row) {
        case ProjectionRow:
            return [self projectorSocketSettingCell:tableView indexPath:indexPath];
        case ClusterRow:
            return [self switchSocketSettingCell:tableView indexPath:indexPath];
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
            cell.textLabel.text=@"集群设置";
            break;
        case ProjectionRow:
            cell.textLabel.text=@"ProjectionSetting";
            break;

        default:
            cell.textLabel.text=@"UnknownSetting";
            break;
    }
    return cell;
}

-(UITableViewCell*)projectorSocketSettingCell:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath
{
    static NSString*settingCell=@"ProjectorSettingCell";
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:settingCell forIndexPath:indexPath];
    cell.textLabel.text=@"投影仪设置";
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
