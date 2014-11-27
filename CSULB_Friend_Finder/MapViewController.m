
#import "MapViewController.h"

@implementation MapViewController


#pragma mark - UIViewController

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.rightBarButtonItem = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.detailItem) {
        // obtain the geopoint
        PFGeoPoint *geoPoint = self.detailItem[@"location"];
        
        // center our map view around this geopoint
        self.mapView.region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(geoPoint.latitude, geoPoint.longitude), MKCoordinateSpanMake(0.01f, 0.01f));
        
        // add the annotation
        GeoPointAnnotation *annotation = [[GeoPointAnnotation alloc] initWithObject:self.detailItem];
        
        [self.mapView addAnnotation:annotation];
    }
    else // go to default location: CSULB coordinates
    {
        self.mapView.region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(33.7830f, -118.1129f), MKCoordinateSpanMake(0.01f, 0.01f));
        
        PFQuery *friendsQuery = [PFQuery queryWithClassName:@"Friendship"];
        [friendsQuery whereKey:@"Friend1_Id" equalTo:[[PFUser currentUser] objectId]];
        [friendsQuery selectKeys:@[@"Friend2_Id"]];
        [friendsQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            // Success
            for (PFObject *object in objects)
            {
                NSString *friendId = object[@"Friend2_Id"];
                PFQuery *friendQuery = [PFQuery queryWithClassName:@"_User"];
                [friendQuery whereKey:@"objectId" equalTo:friendId];
                [friendQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                    PFObject *object = objects[0];
                    GeoPointAnnotation *geoPointAnnotation = [[GeoPointAnnotation alloc]
                                                              initWithObject:object];
                    NSLog(@"geoPoint init for friend");
                    [self.mapView addAnnotation:geoPointAnnotation];
                }];
            }
        }];
    }
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
