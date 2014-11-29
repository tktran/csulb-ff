//
//  ViewController.m
//  prar
//
//  Created by Tan Tran on 10/28/14.
//  Copyright (c) 2014 Tan Tran. All rights reserved.
//

#import "NavigationViewController.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController


- (void) alert:(NSString*)title withDetails:(NSString*)details {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message: details
                                                   delegate: nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.prarManager = [[PRARManager alloc] initWithSize:self.view.frame.size
                                                delegate:self
                                               showRadar:true];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.locationManager = [appDelegate locationManager];
    self.locationManager.delegate = self;
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.detailItem) {
        [self.locationManager startUpdatingLocation];
    }
    else
    {
        NSLog(@"error: no user given to navigation view");
        // go back
    }
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.locationManager stopUpdatingLocation];
    [self.prarManager stopAR];
    self.didStartAR = false;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *) locations
{
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D currentCoordinates = location.coordinate;
    if (self.detailItem && !self.didStartAR)
    {
        // Get the destination (the friend)
        PFUser *friend = (PFUser*) self.detailItem;
        PFGeoPoint *geoPoint = friend[@"location"];
        NSString *friendName = friend[@"first_name"];
        NSArray *friendPRARElement = @[
                                       @{
                                           @"id" : @(0),
                                           @"lat" : @(geoPoint.latitude),
                                           @"lon" : @(geoPoint.longitude),
                                           @"title" : friendName
                                           }];
        
        
        // Start the AR display with source->destination
        [self.prarManager startARWithData:friendPRARElement forLocation:currentCoordinates];
        self.didStartAR = true;
    }
}

#pragma mark - PRAR delegate
- (void)prarDidSetupAR:(UIView *)arView withCameraLayer:(AVCaptureVideoPreviewLayer *)cameraLayer andRadarView:(UIView *)radar
{
    [self.view.layer addSublayer:cameraLayer];
    [self.view addSubview:arView];
    
    [self.view bringSubviewToFront:[self.view viewWithTag:AR_VIEW_TAG]];
    
    [self.view addSubview:radar];
    
}
- (void)prarUpdateFrame:(CGRect)arViewFrame
{
    [[self.view viewWithTag:AR_VIEW_TAG] setFrame:arViewFrame];
    
}

-(void)prarGotProblem:(NSString *)problemTitle withDetails:(NSString *)problemDetails
{
    [self alert:problemTitle withDetails:problemDetails];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
