
#import "MapViewController.h"

@implementation MapViewController


- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.parentViewController.navigationController setNavigationBarHidden:YES];

    self.navigationItem.rightBarButtonItem = nil;
    
    [self.mapView removeAnnotations:self.mapView.annotations];
}

/*!
 @function viewDidAppear
 @abstract When view appears, show all friends of current user as pins
*/
- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.mapView.region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(33.7830f, -118.1151f), MKCoordinateSpanMake(0.015f, 0.015f));
    
    PFQuery *friendsQuery = [PFQuery queryWithClassName:@"Friendship"];
    [friendsQuery whereKey:@"Friend1_Id" equalTo:[[PFUser currentUser] objectId]];
    [friendsQuery selectKeys:@[@"Friend2_Id"]];

    [friendsQuery findObjectsInBackgroundWithBlock:^(NSArray *friendships, NSError *error) {
        // Success
        for (PFObject *friendship in friendships)
        {
            NSString *friendId = friendship[@"Friend2_Id"];
            
            PFQuery *friendQuery = [PFQuery queryWithClassName:@"_User"];
            [friendQuery whereKey:@"objectId" equalTo:friendId];
            [friendQuery getObjectInBackgroundWithId:friendId block:^(PFObject *object, NSError *error) {
                if (!error)
                {
                    BOOL isOnPrivacyMode = [object[@"isOnPrivacyMode"] boolValue];
                    
                    if (!isOnPrivacyMode)
                    {
                        GeoPointAnnotation *geoPointAnnotation = [[GeoPointAnnotation alloc] initWithObject:(PFUser*)object];
                        [self.mapView addAnnotation:geoPointAnnotation];
                    }
                }
                else
                {
                    NSLog(@"MapView loading error: %@", error);
                }
            }];
        }
    }];
    
    // add myself
    GeoPointAnnotation *geoPointAnnotation = [[GeoPointAnnotation alloc] initWithObject:[PFUser currentUser]];
    [self.mapView addAnnotation:geoPointAnnotation];
}

#pragma mark - MKMapViewDelegate

/*!
 @function viewForAnnotation
 @abstract Implementation of MKMapViewDelegate interface. Returns a pin to display on map. Pin is green if current user, red if friends. Pin also has a right info button to go to their profile.
*/
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"AnnotationView"];
    annotationView.canShowCallout = YES;
    annotationView.animatesDrop = YES;
    
    GeoPointAnnotation *geoPointAnnotation = (GeoPointAnnotation*) annotation;
    if (geoPointAnnotation.object == [PFUser currentUser])
        annotationView.pinColor = MKPinAnnotationColorGreen;
    else
        annotationView.pinColor = MKPinAnnotationColorRed;

    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [rightButton addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
    annotationView.rightCalloutAccessoryView = rightButton;
    
    return annotationView;
}

/*!
 @function calloutAccessoryControlTapped
 @abstract When right info button on a pin representing a User is tapped, segue to that User's profile
*/
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    [self performSegueWithIdentifier:@"showProfile" sender:view];
}

/*!
 @function prepareForSegue
 @abstract Pass the user whose profile is to be shown, in the detailItem of ProfileViewController
*/
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(MKAnnotationView *)sender
{
    if ([segue.identifier isEqualToString:@"showProfile"])
    {
        GeoPointAnnotation *selectedPinAnnotation = sender.annotation;
        PFObject *selectedPinUser = selectedPinAnnotation.object;
        [segue.destinationViewController setDetailItem:selectedPinUser];
    }
    else
    {
        NSLog(@"PFS:something else");
    }
}

@end
