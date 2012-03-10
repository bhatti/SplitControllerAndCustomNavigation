#import "MenuCellView.h"

@implementation MenuCellView

@synthesize imageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0.0, 0.0, kMENU_CELL_WIDTH, kMENU_CELL_HEIGHT);
        self.accessoryType = UITableViewCellAccessoryNone;
        self.alpha = 1.000;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.contentMode = UIViewContentModeScaleToFill;
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, kMENU_CELL_WIDTH, kMENU_CELL_HEIGHT)];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        imageView.contentMode = UIViewContentModeScaleToFill;
        
        [self addSubview:imageView];

    }
    return self;
}



- (void)dealloc {
    [imageView release];
    [super dealloc];
}


@end
