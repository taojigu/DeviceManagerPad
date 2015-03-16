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
#import "AsyncSocketController.h"

#import "ClusterCellDataFormatter.h"
#import "ProjectionCellDataFormatter.h"
#import "CoreDataAdaptor.h"


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

    [[CoreDataAdaptor instance] saveCurrentChanges:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath*indexPath=[self.tableView indexPathForSelectedRow];
    UINavigationController*navi=(UINavigationController*)segue.destinationViewController;
    if (1==indexPath.section&&0==indexPath.row) {
        SwitchTableViewController*stvc=(SwitchTableViewController*)navi.topViewController;
        stvc.cellDataFormatter=[[ClusterCellDataFormatter alloc]init];
        stvc.deviceType=DeviceTypeCluster;
        return;
    }
    if (1==indexPath.section&&1==indexPath.row) {
        SwitchTableViewController*stvc=(SwitchTableViewController*)navi.topViewController;
        stvc.cellDataFormatter=[[ProjectionCellDataFormatter alloc]init];
        //stvc.urlString=@"http://163.com";
        stvc.deviceType=DeviceTypeProjection;
        return;
    }
    if (1==indexPath.section&&3==indexPath.row) {
        SwitchTableViewController*stvc=(SwitchTableViewController*)navi.topViewController;
        stvc.cellDataFormatter=[[ClusterCellDataFormatter alloc]init];
        stvc.deviceType=DeviceTypeSoftware;
        return;
    }
    if (0==indexPath.section) {
        
        //StartViewController*stvc=(StartViewController*)navi.topViewController;
       
        return;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (0==section||2==section) {
        return 1;
    }else{
        return 4;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
