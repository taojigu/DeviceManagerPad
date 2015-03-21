

#import "GCDAsyncUdpSocket.h"
@protocol PCommunicaion <NSObject>

-(void)sendPowerOn:(NSString*)hostAddress port:(NSInteger)port;
-(void)sendPowerOff:(NSString*)hostAddress port:(NSInteger)port;


@property(nonatomic,strong)GCDAsyncUdpSocket*udpSocket;

@end