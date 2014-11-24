
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
        CLLocationCoordinate2D csulbCoords;
        csulbCoords.latitude = 33.7830f;
        csulbCoords.longitude = -118.1129f;
        MKCoordinateSpan span;
        span = MKCoordinateSpanMake(0.01f, 0.01f);
        self.mapView.region = MKCoordinateRegionMake(csulbCoords, span);
        
        // run a query for all friends
        CGFloat kilometers = 1.0f; // find friends 1km around you
        
        PFQuery *mapQuery = [PFQuery queryWithClassName:@"_User"];
        [mapQuery setLimit:1000];
        [mapQuery whereKey:@"location"
           nearGeoPoint:[PFGeoPoint geoPointWithLatitude:csulbCoords.latitude
                                               longitude:csulbCoords.longitude]
       withinKilometers:kilometers];
        
        [mapQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                for (PFObject *object in objects) {
                    GeoPointAnnotation *geoPointAnnotation = [[GeoPointAnnotation alloc]
                                                              initWithObject:object];
                    NSLog(@"geoPoint init");
                    [self.mapView addAnnotation:geoPointAnnotation];
                }
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
