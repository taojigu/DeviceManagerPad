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

@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * user;
@property (nonatomic, retain) NSDate * dateTime;

@end
