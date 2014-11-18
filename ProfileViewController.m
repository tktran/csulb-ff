

#import "ProfileViewController.h"


@implementation ProfileViewController


#pragma mark - UIViewController

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // http://keighl.com/post/hide-the-navbar/
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.detailItem) {
        // obtain the geopoint
        PFUser *user = (PFUser*) self.detailItem;
        PFGeoPoint *geoPoint = user[@"location"];
        
        // center our map view around this geopoint
        self.mapView.region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(geoPoint.latitude, geoPoint.longitude), MKCoordinateSpanMake(0.01f, 0.01f));
        
        // add the annotation
        GeoPointAnnotation *annotation = [[GeoPointAnnotation alloc] initWithObject:self.detailItem];
        [self.mapView addAnnotation:annotation];
        
        
        
        // status, location, contact info
        NSString *friendStatus = user[@"status"];
        NSString *friendName = user[@"first_name"];
        friendName = [friendName stringByAppendingString:@" "];
        friendName = [friendName stringByAppendingString:user[@"last_name"]];
        friendName = [@"Name: " stringByAppendingString:friendName];
        friendStatus = [@"Status: " stringByAppendingString:friendStatus];
        self.nameLabel.text = friendName;
        self.statusLabel.text = friendStatus;
        
    }
    else // go to default location: CSULB coordinates
    {
        CLLocationCoordinate2D csulbCoords;
        csulbCoords.latitude = 33.7830f;
        csulbCoords.longitude = -118.1129f;
        MKCoordinateSpan span;
        span = MKCoordinateSpanMake(0.01f, 0.01f);
        self.mapView.region = MKCoordinateRegionMake(csulbCoords, span);
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
        
    return annotationView;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"navigateToFriend"] && self.detailItem) {
        PFObject *friend = self.detailItem;
        [segue.destinationViewController setDetailItem:friend];
    }
}

@end
