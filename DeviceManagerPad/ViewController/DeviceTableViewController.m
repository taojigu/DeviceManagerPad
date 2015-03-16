//
//  DeviceTableViewController.m
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/9.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import "DeviceTableViewController.h"
#import "GCDAsyncUdpSocket.h"
#import "Device.h"
#import "GCDAsyncSocket.h"
#import "GlobalNotification.h"

#define BroadCastPort 0xA001
#define BroadCastAddress @"255.255.255.255"


@interface DeviceTableViewController (){
    
}

@property(nonatomic,strong)NSMutableArray*deviceArray;

-(IBAction)refresh:(id)sender;

@end

@implementation DeviceTableViewController

@synthesize deviceArray;


-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.deviceArray=[[NSMutableArray alloc]init];
    for (NSInteger dvcIndex=0; dvcIndex<8; dvcIndex++) {
        Device*dvc=[Device fakeDevice];
        [self.deviceArray addObject:dvc];
    }
    
    [self udpBroadCast];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.deviceArray count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString*cellIdentifer=@"DeviceCell";
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifer];
    }
    Device*dvc=[self.deviceArray objectAtIndex:indexPath.row];
    cell.textLabel.text=dvc.name;
    cell.detailTextLabel.text=dvc.IP;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Device*dvc=[self.deviceArray objectAtIndex:indexPath.row];
    
    GCDAsyncSocket*socket=[[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    NSError*error=nil;
    BOOL result=[socket connectToHost:dvc.IP onPort:-1 error:&error];
    if (nil!=error||NO==result) {
        NSLog(@"Connect error is %@",[error localizedDescription]);
        
    }
    
    NSDictionary*userInfo=@{DeviceConnectedNotificationKeyDevice:dvc,DeviceConnectedNotificatioonKeySocket:socket};
    NSNotification*notification=[NSNotification notificationWithName:DeviceConnectedNotificationName  object:nil userInfo:userInfo];
    [[NSNotificationCenter defaultCenter]postNotification:notification];
    return;
    
    
}





-(IBAction)refresh:(id)sender{
    [self udpBroadCast];
}

#pragma mark -- UDP socket delegate messages

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data
      fromAddress:(NSData *)address{
    NSString*dataString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"UDP receive data :%@",dataString);
}


#pragma mark -- private messages

-(void)udpBroadCast{

    GCDAsyncUdpSocket*udpSocket=[[GCDAsyncUdpSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    NSError*error=nil;
    BOOL result=[udpSocket enableBroadcast:YES error:&error];
    if (nil!=error) {
        NSLog(@"enable error is %@",[error localizedDescription]);
        return;
    }
    NSString*address=BroadCastAddress;
    //[udpSocket bindToAddress:[address dataUsingEncoding:NSUTF8StringEncoding] error:nil];
    NSError*bindError=nil;
    result=[udpSocket bindToPort:BroadCastPort error:&bindError];
    if (bindError!=nil||NO==result) {
        UIAlertController*alertControler=[UIAlertController alertControllerWithTitle:@"失败" message:@"Udp port bind Failed" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertControler animated:YES completion:nil];
        return;
    }
    result=[udpSocket beginReceiving:&error];
    if (nil!=error||NO==result) {
        NSLog(@"receive error is %@",[error localizedDescription]);
        return;
    }
    NSString*msg=@"?";
    
    [udpSocket sendData:[msg dataUsingEncoding:NSUTF8StringEncoding] toHost:address port:BroadCastPort withTimeout:20 tag:0];

}

@end
