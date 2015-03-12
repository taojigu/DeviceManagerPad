

#import <UIKit/UIKit.h>
@protocol PCellDataFormatter <NSObject>


-(NSInteger)numberOfRows:(UITableView*)tableView section:(NSInteger)section;
-(NSString*)titleForCell:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath;
-(void)parse:(NSData*)data;


@property(nonatomic,assign)BOOL shouldReload;



@end