//
//  OperationLog.h
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/15.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>





@interface OperationLog : NSManagedObject

@property (nonatomic, retain) NSString * commandType;
@property(nonatomic,retain) NSString*commandText;
@property (nonatomic, retain) NSString * user;
@property (nonatomic, retain) NSDate * dateTime;
@property(nonatomic,retain)NSString*deviceIP;
@property(nonatomic,retain)NSString*deviceName;
@property(nonatomic,retain)NSNumber*deviceType;


-(NSString*)operationDecription;

@end
