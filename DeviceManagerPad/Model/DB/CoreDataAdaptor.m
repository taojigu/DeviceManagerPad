//
//  CoreDataAdaptor.m
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/13.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import "CoreDataAdaptor.h"
#import <UIKit/UIKit.h>


@interface CoreDataAdaptor (){
    
}

@property(nonatomic,strong)UIManagedDocument*managedDocument;

@end

@implementation CoreDataAdaptor{
    
}


@synthesize managedDocument;



+(CoreDataAdaptor*)instance{
    static CoreDataAdaptor*fldInstance=nil;
    if (nil==fldInstance) {
        static  dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            fldInstance=[[CoreDataAdaptor alloc]init];
            NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
            url = [url URLByAppendingPathComponent:@"CoreDataTodoItemAdaptor" isDirectory:NO];
            fldInstance=[[CoreDataAdaptor alloc]initWithDocumentUrl:url];
            [fldInstance openCoreDataFile:url error:nil];
        });
    }
    return fldInstance;
}
-(instancetype)initWithDocumentUrl:(NSURL*)docUrl{
    self=[super init];
    NSAssert(docUrl.absoluteString.length>0, @"documnent url is nil");

    self.managedDocument=[[UIManagedDocument alloc]initWithFileURL:docUrl];
    
    return self;
}

-(void)openCoreDataFile:(NSURL*)fileURL error:(NSError *__autoreleasing *)error{
    NSFileManager*fileManager=[NSFileManager defaultManager];
    
    __block BOOL finishedOpen=NO;
    
    NSError*resultError=[NSError errorWithDomain:@"Open todo item file failed" code:-1 userInfo:nil];
    
    if ([fileManager fileExistsAtPath:fileURL.path]) {
        [self.managedDocument openWithCompletionHandler:^(BOOL success) {
            finishedOpen=YES;
            if (success) {
                NSLog(@"Open Sucess");
                
            }
            else{
                NSLog(@"Faile to open");
            }
        }];
    }
    else{
        [self.managedDocument saveToURL:fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            finishedOpen=YES;
            if (success) {
                NSLog(@"Save success");
            }
            else{
                NSLog(@"Fail to save");
                (*error)=resultError;
            }
        }];
    }
}
- (void)saveCurrentChanges:(NSError **)error {
    
    [self.managedDocument.managedObjectContext save:error];
    
}
-(void)undoCurrentChanges{
    [self.managedDocument.undoManager undo];
}
-(RemoteDevice*)createNewDevice{
    RemoteDevice*device=[NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([RemoteDevice class]) inManagedObjectContext:self.managedDocument.managedObjectContext];
    return device;
}

-(void)deleteDevice:(RemoteDevice*)device{
    [self.managedDocument.managedObjectContext deleteObject:device];
    [self saveCurrentChanges:nil];
}

-(NSArray*)deviceArray:(DeviceType)deviceType{
    NSPredicate*predicate=[NSPredicate predicateWithFormat:@"type==%@",[NSNumber numberWithInteger:deviceType]];
    NSError*fetchError=nil;
    NSSortDescriptor*sort=[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    NSArray*deviceArray=[self fetchResultWithPredicate:NSStringFromClass([RemoteDevice class]) predicate:predicate sortDescriptorArray:@[sort] error:&fetchError];
    
  
    return deviceArray;
}



-(void)insertOperationLog:(NSString*)userName commandType:(NSString*)commandType device:(RemoteDevice*)device dateTime:(NSDate*)dateTime{
    OperationLog*log=[NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([OperationLog class]) inManagedObjectContext:self.managedDocument.managedObjectContext];
    log.user=userName;
    log.commandType=commandType;
    log.deviceIP=device.deviceIP;
    log.deviceName=device.name;
    log.deviceType=device.type;
    log.dateTime=dateTime;
    
    [self saveCurrentChanges:nil];
    
}
-(void)insertOperationLog:(NSString *)userName comandType:(NSString *)commandType commandText:(NSString*)commandText dateTime:(NSDate *)dateTime{
    OperationLog*log=[NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([OperationLog class]) inManagedObjectContext:self.managedDocument.managedObjectContext];
    log.user=userName;
    log.commandType=commandType;
    log.commandText=commandText;
    log.dateTime=dateTime;
    
    [self saveCurrentChanges:nil];
    
}
-(NSArray*)operationLogArray:(NSDate*)afterDate{
    
    NSPredicate*predicate=[NSPredicate predicateWithFormat:@"dateTime>=%@",afterDate];
    NSSortDescriptor*sort=[NSSortDescriptor sortDescriptorWithKey:@"dateTime" ascending:NO];
    NSArray*logArray=[self fetchResultWithPredicate:NSStringFromClass([OperationLog class]) predicate:predicate sortDescriptorArray:@[sort] error:nil];
    
    return logArray;
}


#pragma mark -- private messages

-(NSArray*)fetchResultWithPredicate:(NSString*)entityName predicate:(NSPredicate*)predicate sortDescriptorArray:(NSArray*)sortDescritptorArray error:(NSError* __autoreleasing*)error{
    
    NSFetchRequest*fetchRequest=[[NSFetchRequest alloc]initWithEntityName:entityName];
    
    if (predicate!=nil) {
        fetchRequest.predicate=predicate;
    }
    if (nil!=sortDescritptorArray) {
        fetchRequest.sortDescriptors=sortDescritptorArray;
    }
    
    NSError*fetchError=nil;
    NSArray*resultArray=[self.managedDocument.managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
    if (nil!=fetchError) {
        (*error)=fetchError;
        return nil;
    }
    
    return resultArray;
}


@end
