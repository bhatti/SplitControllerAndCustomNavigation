#import "CustomNavigationController.h"
#import "MenuViewController.h"
#import "Configuration.h"
#import "AppDelegate.h"

@implementation CustomNavigationController

@synthesize controllers;

static NSArray *kControllerNames;

+ (void) initialize {
    kControllerNames = [[NSArray arrayWithObjects:@"One", @"Two", @"Three", @"Four", @"Five", @"Six", @"Seven", @"Eight", @"Nine", @"Ten", nil] retain];    
}



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    controllers = [[NSMutableArray alloc] initWithCapacity:10];
    [super setEditing:YES animated:YES];
    [self.tableView setEditing:YES animated:YES];
    self.navigationItem.title = @"Navigation";
    self.tableView.backgroundColor = [UIColor clearColor];
	[self.tableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
	self.tableView.separatorColor = [UIColor blackColor];
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [controllers removeAllObjects];
    NSArray *list = [[Configuration sharedConfiguration] getNavigationOrder];
    for (NSString *ctr in list) {
        [controllers addObject:[NSNumber numberWithInt:[ctr intValue]]];
    }
    
    [self.tableView reloadData];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    self.controllers = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [controllers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CustomNavigationCellView";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    

    NSNumber *num = [controllers objectAtIndex:indexPath.row];
    cell.textLabel.text = [kControllerNames objectAtIndex:[num intValue]];

    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}



- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}


- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView reloadData];    
}


#pragma mark Row reordering
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath
      toIndexPath:(NSIndexPath *)toIndexPath {
    NSNumber *item = [[controllers objectAtIndex:fromIndexPath.row] retain];
    [controllers removeObject:item];
    [controllers insertObject:item atIndex:toIndexPath.row];
    [item release];

    NSMutableArray *list = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
    for (NSNumber *num in controllers) {
        [list addObject:[num stringValue]];
    }
    [[Configuration sharedConfiguration] setNavigationOrder:list];

    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    [delegate.splitViewController.menuViewController refresh];
}



- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

-(void)dealloc {
    [controllers release];
    [super dealloc];
}
@end
