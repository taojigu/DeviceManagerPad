

#import "GCDAsyncUdpSocket.h"
#import "GCDAsyncSocket.h"
@class RemoteDevice;
@protocol PCommunicaion <NSObject>

@required
//-(void)sendPowerOn:(NSString*)hostAddress port:(NSInteger)port;
//-(void)sendPowerOff:(NSString*)hostAddress port:(NSInteger)port;

-(void)sendPowerOn:(RemoteDevice*)device;
-(void)sendPowerOff:(RemoteDevice*)device;

@optional
-(void)sendVolumeUp:(NSString*)hostAddress port:(NSInteger)port;
-(void)sendVolumeDown:(NSString*)hostAddress port:(NSInteger)port;


@property(nonatomic,strong)GCDAsyncUdpSocket*udpSocket;
@property(nonatomic,strong)GCDAsyncSocket*tcpSocket;

@end