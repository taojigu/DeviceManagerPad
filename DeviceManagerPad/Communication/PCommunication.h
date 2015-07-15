

#import "GCDAsyncUdpSocket.h"
#import "GCDAsyncSocket.h"
@protocol PCommunicaion <NSObject>

@required
-(void)sendPowerOn:(NSString*)hostAddress port:(NSInteger)port;
-(void)sendPowerOff:(NSString*)hostAddress port:(NSInteger)port;

@optional
-(void)sendVolumeUp:(NSString*)hostAddress port:(NSInteger)port;
-(void)sendVolumeDown:(NSString*)hostAddress port:(NSInteger)port;


@property(nonatomic,strong)GCDAsyncUdpSocket*udpSocket;
@property(nonatomic,strong)GCDAsyncSocket*tcpSocket;

@end