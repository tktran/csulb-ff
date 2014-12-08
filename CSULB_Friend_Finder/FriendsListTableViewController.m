

// PFQueryTableViewController UIStoryboard Template

#import "FriendsListTableViewController.h"

@implementation FriendsListTableViewController

#pragma mark - NSObject

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"geoPointAnnotationUpdated" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Allows current view controller's nav bar to show
    [self.parentViewController.navigationController setNavigationBarHidden:YES];
    self.navigationItem.leftBarButtonItem.enabled = NO;
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadObjects];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return interfaceOrientation == UIInterfaceOrientationPortrait;
}

/*!
 @function prepareForSegue
 @abstract When user selects a friend, segue to the NavigationView, passing in the friend to navigate to
*/
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showProfile"]) {
        NSIndexPath *indexPath =[self.tableView indexPathForSelectedRow];
        PFObject *object = [self.objects objectAtIndex:indexPath.row];
        
        PFUser *user = [PFUser currentUser];
        NSString *friendId;
        if (object[@"Friend1_Id"] == user.objectId)
            friendId = object[@"Friend2_Id"];
        else
            friendId = object[@"Friend1_Id"];
        
        PFQuery *userQuery = [PFQuery queryWithClassName:@"_User"];
        
        [userQuery getObjectInBackgroundWithId:friendId block:^(PFObject *object, NSError *error) {
            [segue.destinationViewController setDetailItem:object];
        }];
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


/*!
 @function queryForTable
 @abstract PFQueryTableView method. Query for all Friendships where current user is in the Friend1_Id field.
 Recall that every friendship has two rows in the Friendship table, with Friend1_Id and Friend2_Id reversed.
 This method will get one of those rows.
*/
- (PFQuery *)queryForTable {
    if ([[PFUser currentUser] objectId] == nil) {
        NSLog(@"No objectID");
        return [[PFQuery alloc] init];
    } else {
        PFQuery *friendsQuery = [PFQuery queryWithClassName:@"Friendship"];
        [friendsQuery whereKey:@"Friend1_Id" equalTo:[[PFUser currentUser] objectId]];
        
        return friendsQuery;
    }
}

/*!
 @function cellForRowAtIndexPath
 @abstract Using the Friendship that was retrieved, run another query to get the User in the
 Friend2_Id field. Display that user's name and location in the cell.
*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    
    // Get a cell
    PFTableViewCell *cell = (PFTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"LocationCell"];
    
    NSString *friendId = object[@"Friend2_Id"];

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
        if (isOnPrivacyMode)
            cell.detailTextLabel.text = @"On privacy mode";
        else if (!isOnCampus)
            cell.detailTextLabel.text = @"Not on campus";
        else
            cell.detailTextLabel.text = [NSString stringWithFormat:@"Around %@",[LocationTranslation closestBuilding:geoPoint]];
    }];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }


#pragma mark - CLLocationManagerDelegate


#pragma mark - MasterViewController

@end