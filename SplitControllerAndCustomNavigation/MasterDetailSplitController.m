#import "MasterDetailSplitController.h"
#import "MenuViewController.h"
#import "MenuCellView.h"


@implementation MasterDetailSplitController

@synthesize menuViewController = _menuViewController;
@synthesize detailsViewController = _detailsViewController;
@synthesize menuView = _menuView;
@synthesize detailsView = _detailsView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
    }
    return self;
}

- (void)dealloc {
    [_menuViewController release];
    [_detailsViewController release];
    [_menuView release];
    [_detailsView release];
    [super dealloc];
}



#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    isPortrait = YES;
    
    self.menuViewController = [[[MenuViewController alloc] initWithSplit:self] autorelease];
    //self.menuViewController.view.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //self.menuViewController.tableView.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.menuViewController.view.frame = CGRectMake(0, 0, self.menuView.frame.size.width, self.menuView.frame.size.height);
    [self.menuView addSubview:self.menuViewController.view];
    self.menuView.transform = CGAffineTransformMakeRotation(-M_PI * 0.5);
    self.menuView.autoresizesSubviews = YES;
    self.menuView.backgroundColor = [UIColor grayColor];
    [self layoutSubviews];

}


- (void)viewDidUnload {
    [super viewDidUnload];
    self.menuViewController = nil;
    self.detailsViewController = nil;
    self.detailsView = nil;
}


- (void) pushToDetailController:(UIViewController *)controller {
    if (self.detailsViewController == controller) {
        return;
    }
    if (self.detailsViewController != nil && [self.detailsViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navCtr = (UINavigationController *)self.detailsViewController;
        if ([navCtr.viewControllers containsObject:controller]) {
            return;
        }
    }
    for (UIView *v in self.detailsView.subviews) {
        [v removeFromSuperview];
    }
    if (![controller isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navCtr = [[[UINavigationController alloc] initWithRootViewController:controller] autorelease];
        [navCtr setDelegate:self];
        controller = navCtr;
    }

    [self layoutSubviews];

    controller.view.frame = CGRectMake(0, 0, self.detailsView.frame.size.width, self.detailsView.frame.size.height);
    controller.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth
    | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin
    | UIViewAutoresizingFlexibleRightMargin  | UIViewAutoresizingFlexibleLeftMargin;
    
    self.detailsView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;    
    self.detailsViewController = controller;
    [self.detailsView addSubview:controller.view];

}




#pragma mark -
#pragma mark STANDARD METHODS

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.menuViewController viewWillAppear:animated];
    [self.detailsViewController viewWillAppear:animated];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.menuViewController viewDidAppear:animated];
    [self.detailsViewController viewDidAppear:animated];    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.menuViewController viewWillDisappear:animated];
    [self.detailsViewController viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.menuViewController viewDidDisappear:animated];
    [self.detailsViewController viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES; 
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    isPortrait = toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown;
    if (isPortrait) {
        self.menuView.transform = CGAffineTransformMakeRotation(-M_PI * 0.5);
    } else {        
        self.menuView.transform = CGAffineTransformIdentity;
    }
    [self.menuViewController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self.detailsViewController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}


- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    isPortrait = fromInterfaceOrientation != UIInterfaceOrientationPortrait && fromInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
    [self layoutSubviews];
    [self.menuViewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [self.detailsViewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self.menuViewController willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self.detailsViewController willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)willAnimateFirstHalfOfRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self.menuViewController willAnimateFirstHalfOfRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self.detailsViewController willAnimateFirstHalfOfRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)didAnimateFirstHalfOfRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    [self.menuViewController didAnimateFirstHalfOfRotationToInterfaceOrientation:toInterfaceOrientation];
    [self.detailsViewController didAnimateFirstHalfOfRotationToInterfaceOrientation:toInterfaceOrientation];
}

- (void)willAnimateSecondHalfOfRotationFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation duration:(NSTimeInterval)duration {
    [self.menuViewController willAnimateSecondHalfOfRotationFromInterfaceOrientation:fromInterfaceOrientation duration:duration];
    [self.detailsViewController willAnimateSecondHalfOfRotationFromInterfaceOrientation:fromInterfaceOrientation duration:duration];
}


#pragma mark -
#pragma mark Helpers
- (CGSize) sizeRotated {    
    UIScreen *screen = [UIScreen mainScreen];
    CGRect bounds = screen.bounds;
    CGRect appFrame = screen.applicationFrame;
    CGSize size = bounds.size;
    
    float statusBarHeight = MAX((bounds.size.width - appFrame.size.width), (bounds.size.height - appFrame.size.height));
    
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) 
    {
        // we're going to landscape, which means we gotta swap them
        size.width = bounds.size.height;
        size.height = bounds.size.width;
    }
    
    size.height = size.height - statusBarHeight -self.tabBarController.tabBar.frame.size.height;
    return size;
}

- (void) layoutSubviews {    
    CGSize size = [self sizeRotated];
    if (isPortrait) {
        self.detailsView.frame = CGRectMake(0, 0, size.width, size.height-kMENU_CELL_HEIGHT);
        self.menuView.frame = CGRectMake(0.0, size.height-kMENU_CELL_HEIGHT, size.width, kMENU_CELL_HEIGHT);
    } else {        
        self.menuView.frame = CGRectMake(0.0, 0.0, kMENU_CELL_WIDTH, size.height);
        self.detailsView.frame = CGRectMake(kMENU_CELL_WIDTH, 0, size.width-kMENU_CELL_WIDTH, size.height);
    }
}



- (void) loadView {
    CGSize size = [self sizeRotated];
    
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)] autorelease];
    view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.view = view;
    
    self.menuView = [[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, kMENU_CELL_WIDTH, size.height)] autorelease];
    self.menuView.autoresizesSubviews = YES;
    self.menuView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
    self.menuView.backgroundColor = [UIColor colorWithWhite:1.000 alpha:1.000];
    self.menuView.contentMode = UIViewContentModeScaleToFill;
    self.detailsView = [[[UIView alloc] initWithFrame:CGRectMake(kMENU_CELL_WIDTH, 0, size.width-kMENU_CELL_WIDTH, size.height)] autorelease];
    self.detailsView.autoresizesSubviews = YES;
    self.detailsView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.detailsView.backgroundColor = [UIColor colorWithWhite:1.000 alpha:1.000];
    self.detailsView.contentMode = UIViewContentModeScaleToFill;
    
    [self.view addSubview:self.menuView];
    [self.view addSubview:self.detailsView];
}




@end
