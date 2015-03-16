//
//  AppDelegate.m
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/7.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import "AppDelegate.h"
#import "DetailViewController.h"
#import "GlobalNotification.h"
#import "DeviceTableViewController.h"
#import "AsyncSocketController.h"
#import "GCDAsyncSocket.h"
#import "MasterViewController.h"

@interface AppDelegate () <UISplitViewControllerDelegate>{
    
}

@property(nonatomic,strong)UIViewController*rootViewController;


@end

@implementation AppDelegate

@synthesize rootViewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.rootViewController=self.window.rootViewController;
    
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController*loginViewController=[storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    self.window.rootViewController=loginViewController;

    [self addNotificationCenterObservers];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Split view

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    if ([secondaryViewController isKindOfClass:[UINavigationController class]] && [[(UINavigationController *)secondaryViewController topViewController] isKindOfClass:[DetailViewController class]] && ([(DetailViewController *)[(UINavigationController *)secondaryViewController topViewController] detailItem] == nil)) {
        // Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
        return YES;
    } else {
        return NO;
    }
}
#pragma mark  -- Notification Messages

-(void)userDidLoginNotificationReceived:(NSNotification*)notification{
    NSAssert(nil!=self.rootViewController, @"Root View Controller should not be nil");

    self.window.rootViewController=self.rootViewController;
}
-(void)deviceConnectedNotificationReceived:(NSNotification*)notification{
     NSAssert(nil!=self.rootViewController, @"Root View Controller should not be nil");
   
    
    GCDAsyncSocket*socket=[notification.userInfo objectForKey:DeviceConnectedNotificatioonKeySocket];
    Device*dvc=[notification.userInfo objectForKey:DeviceConnectedNotificationKeyDevice];
    
    UISplitViewController*splitViewController=(UISplitViewController*)self.rootViewController;
    
    UINavigationController*masterNavi=(UINavigationController*)splitViewController.viewControllers.firstObject;
    AsyncSocketController*socketController=[[AsyncSocketController alloc]initWithSocket:socket device:dvc];
    
    MasterViewController*mvc=(MasterViewController*)masterNavi.topViewController;
    mvc.socketController=socketController;
    

   
  

     self.window.rootViewController=self.rootViewController;
    
}

#pragma mark -- UISplitViewController delegate



#pragma mark - private messages

-(void)addNotificationCenterObservers{
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceConnectedNotificationReceived:) name:DeviceConnectedNotificationName object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userDidLoginNotificationReceived:) name:LoginSuccessNotificationName object:nil];
}

@end
