#import <UIKit/UIKit.h>

@interface CustomNavigationController : UITableViewController<UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray *controllers;
}

@property(nonatomic, retain) NSMutableArray *controllers;

@end
