//
//  HomeScreenViewController.m
//  CSULB_Friend_Finder
//
//  Created by Gustavo Yepes on 9/24/14.
//  Copyright (c) 2014 Gustavo Yepes. All rights reserved.
//

#import "HomeScreenViewController.h"

@interface HomeScreenViewController ()

@end

@implementation HomeScreenViewController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    self.navigationItem.leftBarButtonItem=nil;
    self.navigationItem.rightBarButtonItem.style = UIBarButtonSystemItemAdd;
    self.navigationItem.rightBarButtonItem.enabled = YES;
    self.navigationItem.hidesBackButton = YES;
    
    CLLocationCoordinate2D csulbCoords;
    csulbCoords.latitude = 33.7830f;
    csulbCoords.longitude = -118.1129f;
    MKCoordinateSpan span;
    span = MKCoordinateSpanMake(0.01f, 0.01f);
    self.mapView.region = MKCoordinateRegionMake(csulbCoords, span);
}

-(void) updateTextLabels {
    // Allows current view controller's nav bar to show
    [self.parentViewController.navigationController setNavigationBarHidden:YES];
    
    PFUser *user = [PFUser currentUser];
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@",user[@"first_name"], user[@"last_name"]];
    NSLog(@"%@", user[@"last_name"]);
    
    PFGeoPoint *geoPoint = user[@"location"];
    NSString *string = [NSString stringWithFormat:@"Your location is: %.2f, %.2f", geoPoint.latitude, geoPoint.longitude];
    self.locationLabel.text = string;

}
- (IBAction)updateLocation:(id)sender {
    // If it's not possible to get a location, then return.
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    CLLocation *location = appDelegate.locationManager.location;
    if (!location) {
        return;
    }
    
    // Configure the new event with information from the location.
    CLLocationCoordinate2D coordinate = [location coordinate];
    PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    PFUser *user = [PFUser currentUser];
    [user setObject:geoPoint forKey:@"location"];
    
    [user saveEventually:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // Reload the PFQueryTableViewController
            [self updateTextLabels];
        }
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateTextLabels];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
