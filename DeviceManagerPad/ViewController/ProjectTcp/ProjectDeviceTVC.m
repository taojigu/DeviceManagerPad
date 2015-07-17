//
//  ProjectDeviceTVC.m
//  DeviceManagerPad
//
//  Created by gus on 15/7/17.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import "ProjectDeviceTVC.h"
#import "SwitchCell.h"
#import "UIControl+IndexPath.h"
#import "CoreDataAdaptor.h"

@interface ProjectDeviceTVC ()
{
    
}

@property(nonatomic,strong)NSMutableArray*devicArray;
@property(nonatomic,strong)NSMutableArray*tcpSocketControlArray;

@end

@implementation ProjectDeviceTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self privateInit];
    [self initSubviews];
    [self readDeviceDataFromCoreData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)privateInit
{
    self.devicArray = [NSMutableArray array];
    self.tcpSocketControlArray = [NSMutableArray array];
}
-(void)initSubviews
{
    if (self.editable)
    {
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self numberOfSection:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self addDeviceSeciton]==section||[self sendAllSection]==section) {
        return 1;
    }
    else{
        return self.devicArray.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==[self addDeviceSeciton]) {
        return  [self addDeviceCell:tableView indexPath:indexPath];
    }
    
    if (indexPath.section==[self sendAllSection]) {
        return [self sendAllDeviceCell:tableView indexPath:indexPath];
    }
    
    static NSString*cellIdentifer= @"SwitchCell1";
    SwitchCell *cell = (SwitchCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifer forIndexPath:indexPath];
    cell.powerOnButton.indexPath=indexPath;
    cell.powerOffButton.indexPath=indexPath;
    
    RemoteDevice*device=[self.devicArray objectAtIndex:indexPath.row];
    cell.titleLabel.text=device.name;
    cell.subTitleLabel.text=[NSString stringWithFormat:@"%@:%@",device.deviceIP,device.port];
    
    
    return cell;
}


-(UITableViewCell*)addDeviceCell:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath{
    static NSString*addDeviceCell=@"AddDeviceCell";
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:addDeviceCell];
    cell.textLabel.text=@"添加设备";
    return cell;
}

-(UITableViewCell*)sendAllDeviceCell:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath
{
    static NSString*cellIdentifer= @"SwitchCell";
    SwitchCell *cell = (SwitchCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifer forIndexPath:indexPath];
    cell.powerOnButton.indexPath=indexPath;
    cell.powerOffButton.indexPath=indexPath;
    
    cell.titleLabel.text=@"所有设备";
    cell.subTitleLabel.text=@"所有设备IP";
    return cell;
}

-(void)readDeviceDataFromCoreData{
    
    [self.devicArray removeAllObjects];
    [self.devicArray addObjectsFromArray:[[CoreDataAdaptor instance] deviceArray:self.deviceType]];
    [self.tableView reloadData];
}

-(NSInteger)numberOfSection:(UITableView*)tableView
{
    if (self.editable) {
        return 3;
    }
    else{
        return 2;
    }
}
-(NSInteger)addDeviceSeciton
{
    if (self.editable) {
        return 0;
    }
    else{
        return -1;
    }
}
-(NSInteger)sendAllSection
{
    if (self.editable) {
        return 1;
    }
    else{
        return 0;
    }
}

@end
