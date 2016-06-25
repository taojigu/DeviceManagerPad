//
//  SwitchTableViewController.m
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/8.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import "SwitchTableViewController.h"
#import "CoreDataAdaptor.h"
#import "DeviceDetailViewController.h"
#import "CoreDateTypeUtility.h"

#import "SwitchCell.h"
#import "UIControl+IndexPath.h"
#import "UserManagement.h"




//#define AddRowSection 0
//#define SendAllSection 1

@interface SwitchTableViewController ()<DeviceDetailViewControllerDelegate>{
    
}


@property(nonatomic,strong)NSMutableArray*devicArray;

@end

@implementation SwitchTableViewController
@synthesize communication;
@synthesize devicArray;

/**
 *  标示色否可以编辑设备
 */
@synthesize editable;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.devicArray=[[NSMutableArray alloc]init];
    [self initSubviews];
    [self readDeviceDataFromCoreData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  [self numberOfSection:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return [self.cellDataFormatter numberOfRows:tableView section:section];
    if ([self addDeviceSeciton]==section||[self sendAllSection]==section) {
        return 1;
    }
    else{
        return self.devicArray.count;
    }
}


-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if ([self addDeviceSeciton]==section||[self sendAllSection]==section) {
        return nil;
    }
    else{
        return @"设备列表";
    }
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==[self addDeviceSeciton]) {
        return  [self addDeviceCell:tableView indexPath:indexPath];
    }
    
    if (indexPath.section==[self sendAllSection]) {
        return [self sendAllDeviceCell:tableView indexPath:indexPath];
    }
    
    static NSString*cellIdentifer= @"SwitchCell";
    SwitchCell *cell = (SwitchCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifer forIndexPath:indexPath];
    UIImage*powerOnImage  = [UIImage imageNamed:@"PowerOn"];
    UIImage *powerOffImage =[UIImage imageNamed:@"PowerOff"];
    
    cell.powerOnButton.indexPath=indexPath;
    [cell.powerOnButton setBackgroundImage:powerOnImage forState:UIControlStateNormal];
    cell.powerOffButton.indexPath=indexPath;
    [cell.powerOffButton setBackgroundImage:powerOffImage forState:UIControlStateNormal];

    RemoteDevice*device=[self.devicArray objectAtIndex:indexPath.row];
    cell.titleLabel.text=device.name;
    if(device.powerOffCmd.length>0&&device.powerOnCmd.length>0)
    {
        cell.subTitleLabel.text =[NSString stringWithFormat:@"%@:%@ On:%@ Off:%@",device.deviceIP,device.port,device.powerOnCmd,device.powerOffCmd];
    }
    else
    {
        cell.subTitleLabel.text=[NSString stringWithFormat:@"%@:%@",device.deviceIP,device.port];
        
    }
    
    

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.editable==NO) {
        return;
    }
    if (indexPath.section==[self sendAllSection]) {
        return;
    }
    [self performSegueWithIdentifier:@"SeguePushDetail" sender:self];
 
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section==[self addDeviceSeciton]||indexPath.section==[self sendAllSection]){
        return NO;
    }
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSAssert(indexPath.section!=[self addDeviceSeciton], @"not this section should be delegte");
        NSAssert(indexPath.section!=[self sendAllSection], @"not this section should be delegte");
        // Delete the row from the data source
        RemoteDevice*device=[self.devicArray objectAtIndex:indexPath.row];
        [[CoreDataAdaptor instance] deleteDevice:device];
        [self.devicArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 72;
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSIndexPath*indexPath=[self.tableView indexPathForSelectedRow];
    UIViewController*destViewContrller=(UIViewController*)segue.destinationViewController;
    if ([DeviceDetailViewController class]==[destViewContrller class]) {
        DeviceDetailViewController*ddvc=(DeviceDetailViewController*)destViewContrller;
        ddvc.delegate=self;
        ddvc.deviceType=self.deviceType;
        if ([self addDeviceSeciton]==indexPath.section) {
            ddvc.remoteDevice=nil;
            ddvc.detailType=DetailTypeAdd;
            RemoteDevice*dvc=[[CoreDataAdaptor instance] createNewDevice];
            dvc.name=[CoreDateTypeUtility titleForDeviceType:self.deviceType];
            dvc.port=[NSNumber numberWithInteger:8080];
            dvc.deviceIP=@"192.168.1.1";
            dvc.type=[NSNumber numberWithInteger:self.deviceType];
            ddvc.remoteDevice=dvc;
            return;
            
        }else{
            NSAssert([self addDeviceSeciton]!=indexPath.section, @"no segue for send all section");
        
            RemoteDevice*rdice=[self.devicArray objectAtIndex:indexPath.row];
            ddvc.remoteDevice=rdice;
            ddvc.detailType=DetailTypeEdit;
        }
    }
}

#pragma mark -- selector messages

-(IBAction)powerOnButtonClicked:(id)sender{
    UIButton*btn=(UIButton*)sender;
    NSString*userName=[[NSUserDefaults standardUserDefaults]objectForKey:LoginUserNameKey];
    if ([self sendAllSection]==btn.indexPath.section)
    {
        
        for (RemoteDevice*dvc in self.devicArray)
        {
            if (nil!=self.comandBlock)
            {
                self.comandBlock(self,DeviceCommandTypePowerOn,dvc);
            }
            else
            {
                [self.communication sendPowerOn:dvc];
            }
        }
        NSString*deviceTypeName=[CoreDateTypeUtility titleForDeviceType:self.deviceType];
        NSString*commandText=[NSString stringWithFormat:@"发送 PowerON to all %@",deviceTypeName];
        [[CoreDataAdaptor instance] insertOperationLog:userName comandType:DeviceCommandTypePowerOnAll commandText:commandText dateTime:[NSDate date]];
    }
    else
    {
        
        RemoteDevice*dvc=[self.devicArray objectAtIndex:btn.indexPath.row];
        if (nil!=self.comandBlock)
        {
            self.comandBlock(self,DeviceCommandTypePowerOn,dvc);
        }
        else
        {

            [self.communication sendPowerOn:dvc];
           
        }
         [[CoreDataAdaptor instance] insertOperationLog:userName commandType:DeviceCommandTypePowerOn device:dvc dateTime:[NSDate date]];
    }
}

-(IBAction)powerOffButtonClicked:(id)sender{
    UIButton*btn=(UIButton*)sender;
    NSString*userName=[[NSUserDefaults standardUserDefaults]objectForKey:LoginUserNameKey];
    NSInteger section=btn.indexPath.section;
    if ([self sendAllSection]==section) {
        for (RemoteDevice*dvc in self.devicArray)
        {
            if (self.comandBlock!=nil)
            {
                self.comandBlock(self,DeviceCommandTypePowerOff,dvc);
            }
            else
            {
                [self.communication sendPowerOff:dvc];
            }
        }
        NSString*deviceTypeName=[CoreDateTypeUtility titleForDeviceType:self.deviceType];
        NSString*commandText=[NSString stringWithFormat:@"发送 PowerOff to all %@",deviceTypeName];
        [[CoreDataAdaptor instance] insertOperationLog:userName comandType:DeviceCommandTypePowerOfAll commandText:commandText dateTime:[NSDate date]];
    }
    else{
        
        RemoteDevice*dvc=[self.devicArray objectAtIndex:btn.indexPath.row];
        
        if (self.comandBlock!=nil)
        {
            self.comandBlock(self,DeviceCommandTypePowerOff,dvc);
        }
        else
        {
            [self.communication sendPowerOff:dvc];
        };
        
        [[CoreDataAdaptor instance] insertOperationLog:userName commandType:DeviceCommandTypePowerOff device:dvc dateTime:[NSDate date]];

    }
   
}

#pragma mark -- DeviceDetailViewController Delegate messages
-(void)remoteDeviceDidAdded:(DeviceDetailViewController *)viewConroller remotedDevice:(RemoteDevice *)remoteDevice{
    [[CoreDataAdaptor instance] saveCurrentChanges:nil];
    [self.devicArray removeAllObjects];
    [self.devicArray addObjectsFromArray:[[CoreDataAdaptor instance] deviceArray:self.deviceType]];
    [self.tableView reloadData];
}
-(void)remoteDeviceDidUpdated:(DeviceDetailViewController *)viewConroller remotedDevice:(RemoteDevice *)remoteDevice{
    
    [[CoreDataAdaptor instance] saveCurrentChanges:nil];
    [self readDeviceDataFromCoreData];

    
}
-(void)remoteDeviceEditCanceled:(DeviceDetailViewController *)viewController{
    
    [[CoreDataAdaptor instance] undoCurrentChanges];
}

#pragma mark -- private messages

-(UITableViewCell*)addDeviceCell:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath{
    static NSString*addDeviceCell=@"AddDeviceCell";
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:addDeviceCell];
    cell.textLabel.text=@"添加新设备";
    return cell;
}

-(UITableViewCell*)sendAllDeviceCell:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath{
    static NSString*cellIdentifer= @"SwitchCell";
    SwitchCell *cell = (SwitchCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifer forIndexPath:indexPath];
    UIImage*powerOnImage  = [UIImage imageNamed:@"PowerOn"];
    UIImage *powerOffImage =[UIImage imageNamed:@"PowerOff"];
    
    cell.powerOnButton.indexPath=indexPath;
    [cell.powerOnButton setBackgroundImage:powerOnImage forState:UIControlStateNormal];
    cell.powerOffButton.indexPath=indexPath;
    [cell.powerOffButton setBackgroundImage:powerOffImage forState:UIControlStateNormal];
    cell.isAllSwitch=YES;
    cell.titleLabel.text=@"所有设备";
    cell.subTitleLabel.text=@"所有设备IP";
    return cell;
}

-(void)readDeviceDataFromCoreData{
    
    [self.devicArray removeAllObjects];
    [self.devicArray addObjectsFromArray:[[CoreDataAdaptor instance] deviceArray:self.deviceType]];
    [self.tableView reloadData];
}

-(void)initSubviews{
    if (self.editable) {
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
    }
}
-(void)sendCommnad2Device:(NSString*)cmdString device:(RemoteDevice*)device
{
    
}

-(NSInteger)numberOfSection:(UITableView*)tableView{
    if (self.editable) {
        return 3;
    }
    else{
        return 2;
    }
}
-(NSInteger)addDeviceSeciton{
    if (self.editable) {
        return 0;
    }
    else{
        return -1;
    }
}
-(NSInteger)sendAllSection{
    if (self.editable) {
        return 1;
    }
    else{
        return 0;
    }
}


@end
