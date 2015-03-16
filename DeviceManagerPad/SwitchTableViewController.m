//
//  SwitchTableViewController.m
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/8.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import "SwitchTableViewController.h"
#import "AFHTTPRequestOperation.h"
#import "PCellDataFormatter.h"
#import "CoreDataAdaptor.h"
#import "DeviceDetailViewController.h"
#import "CoreDateTypeUtility.h"




#define AddRowSection 0

@interface SwitchTableViewController ()<DeviceDetailViewControllerDelegate>{
    
}


@property(nonatomic,strong)NSMutableArray*devicArray;

@end

@implementation SwitchTableViewController


@synthesize devicArray;

@synthesize cellDataFormatter;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.devicArray=[[NSMutableArray alloc]init];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self readDeviceDataFromCoreData];
    //[self startRequestCellData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return [self.cellDataFormatter numberOfRows:tableView section:section];
    if (AddRowSection==section) {
        return 1;
    }
    else{
        return self.devicArray.count;
    }
}


-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (AddRowSection==section) {
        return nil;
    }
    else{
        return @"设备列表";
    }
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString*cellIdentifer= @"SwitchCell";
    if (indexPath.section==AddRowSection) {
        return  [self addDeviceCell:tableView indexPath:indexPath];
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer forIndexPath:indexPath];
    

    if (AddRowSection==indexPath.section) {
        cell.textLabel.text=@"Add Device";
    }
    else{
        RemoteDevice*device=[self.devicArray objectAtIndex:indexPath.row];
        cell.textLabel.text=device.name;
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self performSegueWithIdentifier:@"SeguePushDetail" sender:self];
 
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section==AddRowSection){
        return NO;
    }
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSAssert(indexPath.section!=AddRowSection, @"not this section should be delegte");
        // Delete the row from the data source
        RemoteDevice*device=[self.devicArray objectAtIndex:indexPath.row];
        [[CoreDataAdaptor instance] deleteDevice:device];
        [self.devicArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
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
        if (AddRowSection==indexPath.section) {
            ddvc.remoteDevice=nil;
            ddvc.detailType=DetailTypeAdd;
            RemoteDevice*dvc=[[CoreDataAdaptor instance] createNewDevice];
            dvc.name=[CoreDateTypeUtility titleForDeviceType:self.deviceType];
            dvc.port=[NSNumber numberWithInteger:8080];
            dvc.deviceIP=@"192.168.1.1";
            dvc.type=[NSNumber numberWithInteger:self.deviceType];
            ddvc.remoteDevice=dvc;
            
        }
        else{
            RemoteDevice*rdice=[self.devicArray objectAtIndex:indexPath.row];
            ddvc.remoteDevice=rdice;
            ddvc.detailType=DetailTypeEdit;
        }
        return;
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
    cell.textLabel.text=@"Add Device";
    return cell;
}


-(void)readDeviceDataFromCoreData{
    
    [self.devicArray removeAllObjects];
    [self.devicArray addObjectsFromArray:[[CoreDataAdaptor instance] deviceArray:self.deviceType]];
    [self.tableView reloadData];
}

-(void)startRequestCellData{
    
    NSDictionary*paraDict=@{@"pk_uuid":@"gujitao"};
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:nil parameters:paraDict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } error:nil];
    
    
    AFHTTPRequestOperation *opration = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    NSMutableSet*contentSet=[[NSMutableSet alloc]init];
    [contentSet addObject:@"text/html"];
    [contentSet addObject:@"application/json"];
    opration.responseSerializer.acceptableContentTypes = contentSet;
    
    [opration setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, NSData* responseObject) {
        NSLog(@"Sucess:%@",responseObject);
        [self.cellDataFormatter parse:responseObject];
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failed:%@",[error localizedDescription]);
        
    }];
    [opration start];
    
}
@end
