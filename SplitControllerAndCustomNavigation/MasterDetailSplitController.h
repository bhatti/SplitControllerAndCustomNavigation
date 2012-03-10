#import <UIKit/UIKit.h>
@class MenuViewController;


@interface MasterDetailSplitController : UIViewController <UINavigationControllerDelegate>  {
    BOOL isPortrait;

}

@property (nonatomic, retain) IBOutlet MenuViewController *menuViewController;
@property (nonatomic, retain) IBOutlet UIViewController *detailsViewController;
@property (nonatomic, retain) IBOutlet UIView *menuView;
@property (nonatomic, retain) IBOutlet UIView *detailsView;

-(void)pushToDetailController:(UIViewController *)controller;
- (void) layoutSubviews;

@end


