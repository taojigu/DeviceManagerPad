//
//  DeviceTableViewController.m
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/9.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import "DeviceTableViewController.h"
#import "GCDAsyncUdpSocket.h"



@interface DeviceTableViewController (){
    
}

@property(nonatomic,strong)NSMutableArray*deviceArray;

@end

@implementation DeviceTableViewController

@synthesize deviceArray;


-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self udpBroadCast];
    
    GCDAsyncUdpSocket*udpSocket=[[GCDAsyncUdpSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    NSString*address=@"255.255.255.255";
    //[udpSocket bindToAddress:[address dataUsingEncoding:NSUTF8StringEncoding] error:nil];
    NSError*bindError=nil;
    [udpSocket bindToPort:0xA001 error:&bindError];
    if (bindError!=nil) {
        UIAlertController*alertControler=[UIAlertController alertControllerWithTitle:@"失败" message:@"Udp port bind Failed" preferredStyle:UIAlertControllerStyleAlert];

    }

    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*cellIdentifer=@"DeviceCell";
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
    }
    cell.textLabel.text=@"192.168.1.1";
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark -- private messages

-(void)udpBroadCast{

    //255.255.255.255 on port 0xA001.
}

@end
