

#import "ProfileViewController.h"
#import "NavigationViewController.h"

@implementation ProfileViewController




#pragma mark - UIViewController

/*!
 @function viewDidLoad
 @method Upon loading, set the mapView's delegate to self, self implementing UIMapViewDelegate for pin adding
*/
- (void) viewDidLoad
{
    [super viewDidLoad];
    self.mapView.delegate = self;
}

/*!
 @function viewDidAppear
 @method Upon appearance of view, hide the navigation bar (to show all of mapView), and call the two main functions of this VC: updateRightButton and updateDisplayInfo
*/
- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.parentViewController.navigationController setNavigationBarHidden:YES];

    [self updateRightButton];
    [self updateDisplayInfo];
}

/*!
 @function updateRightButton
 @method If a user was passed it, it was a friend to display. Otherwise, it is the current user (user of this app). Hide the poke and findYourFriend buttons.
*/
- (void) updateRightButton {
    if (self.detailItem) // Friend passed. Display friend's profile
    {
        self.navigationItem.rightBarButtonItem.title = @"";
        self.navigationItem.rightBarButtonItem.enabled = NO;
        self.pokeButton.hidden = false;
        self.findYourFriendButton.hidden = false;
    }
    else // No friend passed. Must be displaying my own profile
    {
        // Hide the "Poke" and "Find your friend" buttons
        self.navigationItem.rightBarButtonItem.title = @"Update";
        self.navigationItem.rightBarButtonItem.enabled = YES;
        self.pokeButton.hidden = true;
        self.findYourFriendButton.hidden = true;
    }
}

/*!
 @function updateDisplayInfo
 @abstract Update first name, last name, status, and location on map from user's fields
*/
- (void) updateDisplayInfo {
    PFUser *user;
    if (self.detailItem)
        user = (PFUser*) self.detailItem;
    else
        user = [PFUser currentUser];
    
    self.mapView.region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(33.7830f, -118.1151f), MKCoordinateSpanMake(0.01f, 0.01f));
    GeoPointAnnotation *annotation = [[GeoPointAnnotation alloc] initWithObject:user];
    [self.mapView addAnnotation:annotation];
    
    // status, location, contact info
    NSString *friendStatus = [NSString stringWithFormat:@"Status: %@", user[@"status"]];
    NSString *friendName = [NSString stringWithFormat:@"Name: %@ %@", user[@"first_name"], user[@"last_name"]];
    self.nameLabel.text = friendName;
    self.statusLabel.text = friendStatus;
}

/*!
 @function pressedPokeButton
 @abstract When poke button is pressed, make the relevent Parse Push query and send it to the user
*/
- (IBAction)pressedPokeButton:(id)sender
{
//    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
//    currentInstallation[@"deviceToken"] = @"41283ead3a67860f516dae1006fa903524e424a0337d296b901e4805012a46b3";
//    currentInstallation[@"user"] = [PFUser currentUser].objectId;
//    [currentInstallation save];

    
    PFUser *friend = (PFUser*) self.detailItem;
    
    // only return Installations that belong to the user to poke
    NSString *friendId = self.detailItem.objectId;
    PFQuery *pokeQuery = [PFInstallation query];
    [pokeQuery whereKey:@"user" equalTo:friendId];

    // Create the push using the pokeQuery
    PFPush *push = [[PFPush alloc] init];
    [push setQuery:pokeQuery];
    PFUser *currentUser = [PFUser currentUser];
    NSString *pokeMessage = [NSString stringWithFormat:@"%@ %@ poked you!", currentUser[@"first_name"], currentUser[@"last_name"]];
    [push setMessage:pokeMessage];

    [push sendPushInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
    {
        if (!error)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Poke succeeded!" message:[NSString stringWithFormat:@"%@ was poked!", friend[@"first_name"]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Poke failed" message:@"The poke failed. Try again later." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationMaskPortrait);
}


#pragma mark - MKMapViewDelegate

/*!
 @function viewForAnnotation
 @abstract Implementation of MKMapViewDelegate. Initializes an annotationView using the MKAnnotation passed in.
*/
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Annotation"];
    annotationView.pinColor = MKPinAnnotationColorRed;
    annotationView.canShowCallout = YES;
    annotationView.animatesDrop = YES;
    
    NSLog(@"Hello?");
    return annotationView;
}

/*!
 @function prepareForSegue
 @abstract Upon clicking "Find your friend", pass the PFUser friend to the navigation view controller.
*/
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"navigateToFriend"] && self.detailItem) {
        PFObject *friend = self.detailItem;
        NavigationViewController *dest = [segue destinationViewController];
        dest.hidesBottomBarWhenPushed = YES;
        [dest setDetailItem:friend];
    }
}

@end
