
#import "MapViewController.h"

@implementation MapViewController


#pragma mark - UIViewController

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.parentViewController.navigationController setNavigationBarHidden:YES];

    self.navigationItem.rightBarButtonItem = nil;
    
    [self.mapView removeAnnotations:self.mapView.annotations];
}
- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.detailItem) {
        PFUser *user = (PFUser*) self.detailItem;
        // obtain the geopoint
        PFGeoPoint *geoPoint = user[@"location"];
        
        BOOL isOnPrivacyMode = [user[@"isOnPrivacyMode"] boolValue];
        BOOL isOnCampus = [LocationTranslation isOnCSULBCampus:geoPoint];
        BOOL isCurrentUser = (self.detailItem == [PFUser currentUser]);
        // only display annotation if user is not on privacy mode, and
        // (they are on CSULB campus, or user to display is self)
        if (!isOnPrivacyMode &&
            (isOnCampus || isCurrentUser))
        {
            // center our map view around this geopoint
            self.mapView.region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(geoPoint.latitude, geoPoint.longitude), MKCoordinateSpanMake(0.015f, 0.015f));
            
            // add the annotation
            GeoPointAnnotation *annotation = [[GeoPointAnnotation alloc] initWithObject:user];
            
            [self.mapView addAnnotation:annotation];
        }
    }
    else // go to default location: CSULB coordinates
    {
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
                    BOOL isOnPrivacyMode = [object[@"isOnPrivacyMode"] boolValue];
                    
                    if (!isOnPrivacyMode)
                    {
                        GeoPointAnnotation *geoPointAnnotation = [[GeoPointAnnotation alloc] initWithObject:object];
                        [self.mapView addAnnotation:geoPointAnnotation];
                    }
                }];
            }
        }];
        
        // add myself
        GeoPointAnnotation *geoPointAnnotation = [[GeoPointAnnotation alloc] initWithObject:[PFUser currentUser]];
        [self.mapView addAnnotation:geoPointAnnotation];
    }
}

#pragma mark - MKMapViewDelegate

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

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    [self performSegueWithIdentifier:@"showProfile" sender:view];
}

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
