

#import "ProfileViewController.h"
#import "NavigationViewController.h"

@implementation ProfileViewController




#pragma mark - UIViewController

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self updateRightButton];
    [self updateDisplayInfo];
}

-(IBAction) updateStatus:(UIBarButtonItem*) button
{
    [self performSegueWithIdentifier:@"updateStatusSegue" sender:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) updateRightButton {
    if (self.detailItem) // Friend passed. Display friend's profile
    {
        self.navigationItem.rightBarButtonItem = nil;
        
        self.pokeButton.hidden = false;
        self.findYourFriendButton.hidden = false;
    }
    else // No friend passed. Must be displaying my own profile
    {        
        // Create the Right Bar Button Item: "Update"
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Update" style:UIBarButtonItemStylePlain target:self action:@selector(updateStatus:)];
        rightButton.enabled = true;
        
        self.navigationItem.rightBarButtonItem = rightButton;
        
        // Hide the "Poke" and "Find your friend" buttons
        self.pokeButton.hidden = true;
        self.findYourFriendButton.hidden = true;
    }
}

- (void) updateDisplayInfo {
    PFUser *user;
    if (self.detailItem)
        user = (PFUser*) self.detailItem;
    else
        user = [PFUser currentUser];
    PFGeoPoint *geoPoint = user[@"location"];
    self.mapView.region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(geoPoint.latitude, geoPoint.longitude), MKCoordinateSpanMake(0.01f, 0.01f));
    // add the annotation
    GeoPointAnnotation *annotation = [[GeoPointAnnotation alloc] initWithObject:user];
    [self.mapView addAnnotation:annotation];
    // status, location, contact info
    NSString *friendStatus = [NSString stringWithFormat:@"Status: %@", user[@"status"]];
    NSString *friendName = [NSString stringWithFormat:@"Name: %@ %@", user[@"first_name"], user[@"last_name"]];
    self.nameLabel.text = friendName;
    self.statusLabel.text = friendStatus;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Code for testing push notifications
    // // Create our Installation query
    // PFQuery *pushQuery = [PFInstallation query];
    // [pushQuery whereKey:@"deviceType" equalTo:@"ios"];
    
    // // Send push notification to query
    // [PFPush sendPushMessageToQueryInBackground:pushQuery
    //                                withMessage:@"Hello World!"];
}


- (IBAction)pressedSettingsButton:(id)sender
{
    [self performSegueWithIdentifier:@"settingsSegue" sender:self];
}

- (IBAction)pressedPokeButton:(id)sender
{
    PFUser *friend = (PFUser*) self.detailItem;
    
    // only return Installations that belong to the user to poke
    PFQuery *friendQuery = [PFUser query];
    NSString *friendId = self.detailItem.objectId;
    [friendQuery whereKey:@"objectId" equalTo:friendId];
    
    // Build the actual push notification target query
    PFQuery *pokeQuery = [PFInstallation query];
    [pokeQuery whereKey:@"Owner" matchesQuery:friendQuery];

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

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    static NSString *GeoPointAnnotationIdentifier = @"RedPin";
    
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:GeoPointAnnotationIdentifier];
    
    if (!annotationView) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:GeoPointAnnotationIdentifier];
        annotationView.pinColor = MKPinAnnotationColorRed;
        annotationView.canShowCallout = YES;
        annotationView.draggable = YES;
        annotationView.animatesDrop = YES;
    }
        
    return annotationView;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"navigateToFriend"] && self.detailItem) {
        PFObject *friend = self.detailItem;
        NavigationViewController *dest = [segue destinationViewController];
        dest.hidesBottomBarWhenPushed = YES;
        [dest setDetailItem:friend];
    }
}

@end
