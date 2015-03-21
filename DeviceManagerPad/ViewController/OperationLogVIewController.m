//
//  OperationLogVIewController.m
//  DeviceManagerPad
//
//  Created by GuJitao on 15/3/17.
//  Copyright (c) 2015年 GuJitao. All rights reserved.
//

#import "OperationLogVIewController.h"

#import "CoreDataAdaptor.h"
#import "OperationLog.h"



@interface OperationLogVIewController (){
    
}

@property(nonatomic,strong)IBOutlet UITextView*textView;
@property(nonatomic,strong)IBOutlet UISegmentedControl*segmentControl;



-(IBAction)refreshButtonClicked:(id)sender;

-(IBAction)clearButtonClicked:(id)sender;

@end
@implementation OperationLogVIewController


-(void)viewDidLoad{
    [super viewDidLoad];
    self.segmentControl.selectedSegmentIndex=0;
}

-(IBAction)refreshButtonClicked:(id)sender{
    
    
    [self refresh];


}

-(IBAction)clearButtonClicked:(id)sender{
    

    self.textView.text=nil;
}


#pragma mark -- private messages

-(void)refresh{
    
    NSDate*startDate=[self startDate];
    NSArray*logArray=[[CoreDataAdaptor instance] operationLogArray:startDate];
    NSMutableString*buffer=[[NSMutableString alloc]initWithString:self.textView.text];
    for (OperationLog*log in logArray) {
        NSString*logText=[log operationDecription];
        [buffer appendFormat:@"\r\n %@",logText];
    }
    self.textView.text=buffer;
}

-(NSDate*)startDate{
    NSInteger dayInterval=24*60*60;
    switch (self.segmentControl.selectedSegmentIndex) {
        case 0:
            return [NSDate dateWithTimeIntervalSinceNow:0-7*dayInterval];
        case 1:
            return [NSDate dateWithTimeIntervalSinceNow:0-30*dayInterval];
        case 2:
            return [NSDate dateWithTimeIntervalSinceNow:0-90*dayInterval];
            
        default:
            break;
    }
    NSAssert(NO, @"No this date option");
    return nil;
}

-(void)clearLog{
    
}



@end
