#import "MenuInfo.h"

@implementation MenuInfo
@synthesize label = _label;
@synthesize onImage = _onImage;
@synthesize offImage = _offImage;
@synthesize controller = _controller;

- (id)initWithLabel:(NSString *)theLabel andOnImage:(NSString *)theOnImage andOffImage:(NSString *)theOffImage andController:(UIViewController *)theController {
    self = [super init];
    if (self) {
        self.label = theLabel;
        self.onImage = theOnImage;
        self.offImage = theOffImage;
        self.controller = theController;
    }
    return self;
}
-(void)dealloc {
    [_label release];
    [_onImage release];
    [_offImage release];
    [_controller release];
    [super dealloc];
}
@end