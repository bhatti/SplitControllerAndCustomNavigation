#import <UIKit/UIKit.h>
#import "MasterDetailSplitController.h"


@interface MenuViewController : UITableViewController {
    int selected;
    BOOL isPortrait;
}

@property(nonatomic, retain) NSMutableArray *menuItems;
@property(retain, nonatomic) MasterDetailSplitController *masterDetailSplitController;


- (id)initWithSplit:(MasterDetailSplitController*)split;
- (UIViewController *) selectedController;

-(void)displayControllerView:(UIViewController*)viewController;
-(void)refresh;

@end







