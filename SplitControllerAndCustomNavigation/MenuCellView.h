#import <UIKit/UIKit.h>

#define kMENU_CELL_WIDTH 32
#define kMENU_CELL_HEIGHT 32
@interface MenuCellView : UITableViewCell {
    UIImageView *imageView;
}

@property(nonatomic, retain) IBOutlet UIImageView *imageView;
@end
