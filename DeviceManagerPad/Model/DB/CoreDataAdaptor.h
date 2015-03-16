//
//  CoreDataAdaptor.h
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/13.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RemoteDevice.h"

@interface CoreDataAdaptor : NSObject{
    
}


+(CoreDataAdaptor*)instance;

-(instancetype)initWithDocumentUrl:(NSURL*)docUrl;
-(void)openCoreDataFile:(NSURL*)fileURL error:(NSError *__autoreleasing *)error;
- (void)saveCurrentChanges:(NSError **)error;
-(RemoteDevice*)createNewDevice;
-(void)deleteDevice:(RemoteDevice*)device;

-(void)undoCurrentChanges;



-(NSArray*)deviceArray:(DeviceType)deviceType;

@end
