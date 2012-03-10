#import "SampleTableController.h"


@implementation SampleTableController

@synthesize rows = _rows;
@synthesize heading = _heading;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    if (self.heading == nil) {
        self.heading = @" ";
    }
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    NSMutableArray *arr = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
    for (int i=0; i<20; i++) {
        NSString *value = [NSString stringWithFormat:@"%@ - %d", self.heading, i];
        [arr addObject:value];
    }
    self.rows = arr;
    self.navigationItem.title = self.heading;

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
    return (_rows != nil ? [_rows count] : 0);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RowCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.textLabel.text = (NSString *) [_rows objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)dealloc {
    [_rows release];
    [super dealloc];
}
@end
