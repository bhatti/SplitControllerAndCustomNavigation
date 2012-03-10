#import "MenuViewController.h"
#import "SampleTableController.h"
#import "Configuration.h"
#import "MenuCellView.h"
#import "MenuInfo.h"




@implementation MenuViewController
@synthesize menuItems = _menuItems;
@synthesize masterDetailSplitController = _masterDetailSplitController;

const int kTableLength=320;


- (id)initWithSplit:(MasterDetailSplitController*)split {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {        
        self.masterDetailSplitController = split;
        self.tableView.separatorColor = [UIColor clearColor];
        self.menuItems = [[[NSMutableArray alloc] initWithCapacity:7] autorelease];
    }
    return self;
}


-(void)refresh {
    MenuInfo *menu = nil;
    [self.menuItems removeAllObjects];
    NSArray *orderList = [[Configuration sharedConfiguration] getNavigationOrder];
    for (NSString *order in orderList) {
        MenuKind kind = (MenuKind) [order intValue];
        SampleTableController *ctr = [[[SampleTableController alloc] initWithStyle:UITableViewStylePlain] autorelease];
        switch (kind) {
            case ONE:
                ctr.heading = @"One";
                menu = [[[MenuInfo alloc] initWithLabel:@"One" andOnImage:@"onDown.png" andOffImage:@"offDown.png" andController:ctr] autorelease];
                break;
            case TWO:
                ctr.heading = @"Two";
                menu = [[[MenuInfo alloc] initWithLabel:@"Two" andOnImage:@"onDownLeft.png" andOffImage:@"offDownLeft.png" andController:ctr] autorelease];
                break;
            case THREE:
                ctr.heading = @"Three";
                menu = [[[MenuInfo alloc] initWithLabel:@"Three" andOnImage:@"onDownRight.png" andOffImage:@"offDownRight.png" andController:ctr] autorelease];
                break;
            case FOUR:
                ctr.heading = @"Four";
                menu = [[[MenuInfo alloc] initWithLabel:@"Four" andOnImage:@"onLeft.png" andOffImage:@"offLeft.png" andController:ctr] autorelease];
                break;
            case FIVE:
                ctr.heading = @"Five";
                menu = [[[MenuInfo alloc] initWithLabel:@"Five" andOnImage:@"onNext.png" andOffImage:@"offNext.png" andController:ctr] autorelease];
                break;
            case SIX:
                ctr.heading = @"Six";
                menu = [[[MenuInfo alloc] initWithLabel:@"Six" andOnImage:@"onPrevious.png" andOffImage:@"offPrevious.png" andController:ctr] autorelease];
                break;
            case SEVEN:
                ctr.heading = @"Seven";
                menu = [[[MenuInfo alloc] initWithLabel:@"Seven" andOnImage:@"onRight.png" andOffImage:@"offRight.png" andController:ctr] autorelease];
                break;
            case EIGHT:
                ctr.heading = @"Eight";
                menu = [[[MenuInfo alloc] initWithLabel:@"Eight" andOnImage:@"onUp.png" andOffImage:@"offUp.png" andController:ctr] autorelease];
                break;
            case NINE:
                ctr.heading = @"Nine";
                menu = [[[MenuInfo alloc] initWithLabel:@"Nine" andOnImage:@"onUpLeft.png" andOffImage:@"offUpLeft.png" andController:ctr] autorelease];
                break;
            case TEN:
                ctr.heading = @"Ten";
                menu = [[[MenuInfo alloc] initWithLabel:@"Ten" andOnImage:@"onUpRight.png" andOffImage:@"offUpRight.png" andController:ctr] autorelease];
                break;
        }
        [self.menuItems addObject:menu];
    }
    selected = 0;
    [self.tableView reloadData];
}

- (UIViewController *) selectedController {
    MenuInfo *info = [self.menuItems objectAtIndex:selected];
    return info.controller;
}


- (void)dealloc
{
    [_masterDetailSplitController release];
    [_menuItems release];
    [super dealloc];
}


                               
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    isPortrait = YES;
    UIView *bgView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    bgView.transform = CGAffineTransformMakeRotation(M_PI * 0.5);
    self.tableView.backgroundView = bgView;
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;        
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [UIColor clearColor];
    
    [self refresh];
    [self.masterDetailSplitController pushToDetailController:[self selectedController]];    

}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

-(NSArray *)allControllers {
    NSMutableArray *list = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
    for (MenuInfo *info in self.menuItems) {
        [list addObject:info.controller];
    }
    return list;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    isPortrait = toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown;

    for (UIViewController *ctr in [self allControllers]) {
        [ctr willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    }
    [self.tableView reloadData];
}



- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    for (UIViewController *ctr in [self allControllers]) {
        [ctr didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    }
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    for (UIViewController *ctr in [self allControllers]) {
        [ctr willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    }
}

- (void)willAnimateFirstHalfOfRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    for (UIViewController *ctr in [self allControllers]) {
        [ctr willAnimateFirstHalfOfRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    }
}

- (void)didAnimateFirstHalfOfRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    for (UIViewController *ctr in [self allControllers]) {
        [ctr didAnimateFirstHalfOfRotationToInterfaceOrientation:toInterfaceOrientation];
    }
}

- (void)willAnimateSecondHalfOfRotationFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation duration:(NSTimeInterval)duration {
    for (UIViewController *ctr in [self allControllers]) {
        [ctr willAnimateSecondHalfOfRotationFromInterfaceOrientation:fromInterfaceOrientation duration:duration];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.menuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MenuCell";
    MenuCellView *cell = (MenuCellView *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[MenuCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    }
    MenuInfo *menu = [self.menuItems objectAtIndex:indexPath.row];
    NSString *imageName = selected == indexPath.row ? menu.onImage : menu.offImage;
    cell.imageView.image = [UIImage imageNamed:imageName];
    
    if (isPortrait) {
        cell.transform = CGAffineTransformMakeRotation(M_PI * 0.5);
    } else {
        cell.transform = CGAffineTransformIdentity;        
    }
    
    return cell;
}

/**
 * Displays the specified controller view
 */
-(void) displayControllerView:(UIViewController*)controller {
    if (controller != nil) {
        [self.masterDetailSplitController pushToDetailController:controller];
    }
    [self.tableView reloadData];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    selected = indexPath.row;
    
    UIViewController *controller = [self selectedController];
 
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];

    [self displayControllerView:controller];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return kMENU_CELL_WIDTH * 3;
    } else {
        return kMENU_CELL_WIDTH;
    }
}



@end
