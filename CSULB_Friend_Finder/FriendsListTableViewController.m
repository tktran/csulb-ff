

// PFQueryTableViewController UIStoryboard Template

#import "FriendsListTableViewController.h"

@implementation FriendsListTableViewController

#pragma mark - NSObject

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"geoPointAnnotationUpdated" object:nil];
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Allows current view controller's nav bar to show
    [self.parentViewController.navigationController setNavigationBarHidden:YES];
    self.navigationItem.leftBarButtonItem.enabled = NO;
    self.navigationItem.rightBarButtonItem.enabled = YES;

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return interfaceOrientation == UIInterfaceOrientationPortrait;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showProfile"]) {
        NSIndexPath *indexPath =[self.tableView indexPathForSelectedRow];
        PFObject *object = [self.objects objectAtIndex:indexPath.row];
        NSString *friendId = [object objectForKey:@"Friend2_Id"];
        PFQuery *userQuery = [PFQuery queryWithClassName:@"_User"];
        
        PFObject *friend = [userQuery getObjectWithId:friendId];
        [segue.destinationViewController setDetailItem:friend];
    }
}


#pragma mark - PFQueryTableViewController

- (void)objectsWillLoad {
    [super objectsWillLoad];
    
    // This method is called before a PFQuery is fired to get more objects
}

- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    
    // This method is called every time objects are loaded from Parse via the PFQuery
}


// Override to customize what kind of query to perform on the class. The default is to query for
// all objects ordered by createdAt descending.
- (PFQuery *)queryForTable {
    if ([[PFUser currentUser] objectId] == nil) {
        NSLog(@"No objectID");
        return [[PFQuery alloc] init];
    } else {
        PFQuery *friendsQuery = [PFQuery queryWithClassName:@"Friendship"];
        [friendsQuery whereKey:@"Friend1_Id" equalTo:[[PFUser currentUser] objectId]];
        [friendsQuery selectKeys:@[@"Friend2_Id"]];
        if (self.objects.count == 0) {
            friendsQuery.cachePolicy = kPFCachePolicyCacheThenNetwork;
        }

        return friendsQuery;
    }
}


// Override to customize the look of a cell representing an object. The default is to display
// a UITableViewCellStyleDefault style cell with the label being the textKey in the object,
// and the imageView being the imageKey in the object.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    
    // Get a cell
    PFTableViewCell *cell = (PFTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"LocationCell"];
    
    // Construct query for the friend
    NSString *friendId = [object objectForKey:@"Friend2_Id"];
    PFQuery *friendQuery = [PFQuery queryWithClassName:@"_User"];
    
    // Retrieve friend. Upon success, set cell's title as first_name+last_name
    // and cell's subtitle as closest building, but only if BOTH:
    // 1. friend is on campus
    // 2. friend does not have privacy mode on
    [friendQuery getObjectInBackgroundWithId:friendId block:^(PFObject *object, NSError *error) {
        
        PFGeoPoint *geoPoint = object[@"location"];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", object[@"first_name"], object[@"last_name"]];
        
        BOOL isOnCampus = [LocationTranslation isOnCSULBCampus:geoPoint];
        BOOL isOnPrivacyMode = [object[@"isOnPrivacyMode"] boolValue];
        if (isOnCampus && !isOnPrivacyMode)
        {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"Around %@",[LocationTranslation closestBuilding:geoPoint]];
        }
        else
        {
            cell.detailTextLabel.text = @"Not on campus";
        }
    }];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",[self.objects objectAtIndex:indexPath.row]);
    
}

/*
 // Override if you need to change the ordering of objects in the table.
 - (PFObject *)objectAtIndex:(NSIndexPath *)indexPath {
 return [self.objects objectAtIndex:indexPath.row];
 }
 */


#pragma mark - UITableViewDataSource

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

//  Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }


#pragma mark - CLLocationManagerDelegate


#pragma mark - MasterViewController

@end