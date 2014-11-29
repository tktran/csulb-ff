

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
    
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([appDelegate.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [appDelegate.locationManager requestAlwaysAuthorization ];
    }
    [appDelegate.locationManager startUpdatingLocation];
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
    
    PFTableViewCell *cell = (PFTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"LocationCell"];
    
    NSString *friendId = [object objectForKey:@"Friend2_Id"];
    NSLog(@"%@", friendId);
    
    PFQuery *friendQuery = [PFQuery queryWithClassName:@"_User"];
    [friendQuery getObjectInBackgroundWithId:friendId block:^(PFObject *object, NSError *error) {
        // Success
        // A date formatter for the creation date.
        static NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
            dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.timeStyle = NSDateFormatterMediumStyle;
            dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        }
        
        static NSNumberFormatter *numberFormatter = nil;
        if (numberFormatter == nil) {
            numberFormatter = [[NSNumberFormatter alloc] init];
            numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
            numberFormatter.maximumFractionDigits = 3;
        }
        
        PFGeoPoint *geoPoint = object[@"location"];
        cell.textLabel.text = object[@"first_name"];
        //    cell.detailTextLabel.text = [dateFormatter stringFromDate:object.updatedAt];
//        NSString *string = [NSString stringWithFormat:@"%@, %@",
//                            [numberFormatter stringFromNumber:[NSNumber numberWithDouble:geoPoint.latitude]],
//                            [numberFormatter stringFromNumber:[NSNumber numberWithDouble:geoPoint.longitude]]];
        cell.detailTextLabel.text = [LocationTranslation closestBuilding:geoPoint];

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

/*
 // Override to customize the look of the cell that allows the user to load the next page of objects.
 // The default implementation is a UITableViewCellStyleDefault cell with simple labels.
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForNextPageAtIndexPath:(NSIndexPath *)indexPath {
 static NSString *CellIdentifier = @"NextPage";
 
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
 
 if (cell == nil) {
 cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
 }
 
 cell.selectionStyle = UITableViewCellSelectionStyleNone;
 cell.textLabel.text = @"Load more...";
 
 return cell;
 }
 */


#pragma mark - UITableViewDataSource

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the object from Parse and reload the table view
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, and save it to Parse
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark - CLLocationManagerDelegate

/**
 Conditionally enable the Search/Add buttons:
 If the location manager is generating updates, then enable the buttons;
 If the location manager is failing, then disable the buttons.
 */
//- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
//    self.navigationItem.leftBarButtonItem.enabled = YES;
//    self.navigationItem.rightBarButtonItem.enabled = YES;
//}
//
//- (void)locationManager:(CLLocationManager *)manager
//       didFailWithError:(NSError *)error {
//    self.navigationItem.leftBarButtonItem.enabled = NO;
//    self.navigationItem.rightBarButtonItem.enabled = NO;
//}


#pragma mark - MasterViewController

- (IBAction)addFriend:(id)sender {
    NSLog(@"We should add a view or something to add a friend here. How does Facebook do it?");
}

@end