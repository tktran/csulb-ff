

#import "ProfileViewController.h"


@implementation ProfileViewController


#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.detailItem) {
        NSLog(@"testing");
        // obtain the geopoint
        PFGeoPoint *geoPoint = self.detailItem[@"location"];
        
        // center our map view around this geopoint
        self.mapView.region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(geoPoint.latitude, geoPoint.longitude), MKCoordinateSpanMake(0.01f, 0.01f));
        
        // add the annotation
        GeoPointAnnotation *annotation = [[GeoPointAnnotation alloc] initWithObject:self.detailItem];
        [self.mapView addAnnotation:annotation];
        
        //
        //FBRequest *request = [FBRequest requestForMe];
        //        [request startWithCompletionHandler: ^(FBRequestConnection *connection, id result, NSError *error)
        //         {
        //             if(!error)
        //             {
        //                 NSDictionary *userData = (NSDictionary *)result;
        //                 _NameLabel.adjustsFontSizeToFitWidth = NO;
        //                 _NameLabel.numberOfLines = 0;
        //                 NSString *name = [@"Welcome, " stringByAppendingString:userData[@"name"]];
        //                 name = [name stringByAppendingString:@"\nYou logged in."];
        //                 _NameLabel.text = name;
        //
        //                 // not sure if should get delegate stuff here
        //                 AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        //                 appDelegate.temp_first_name = userData[@"first_name"];
        //
        //                 appDelegate.temp_last_name = userData[@"last_name"];
        //                 appDelegate.temp_email = userData[@"email"];
        //                 [self performSegueWithIdentifier:@"loginSegue" sender:self];
        //                 [self dismissViewControllerAnimated:YES completion:nil];
        //             }
        //         }];
        
        // status, location, contact info
        NSString *friendStatus = self.detailItem[@"status"];
        NSString *friendName = self.detailItem[@"first_name"];
        friendName = [friendName stringByAppendingString:@" "];
        friendName = [friendName stringByAppendingString:self.detailItem[@"last_name"]];
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
        
        // add annotations
        // run a parse query, and for each object, addAnnotation it
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

@end
