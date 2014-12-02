//
//  ViewController.m
//  prar
//
//  Created by Tan Tran on 10/28/14.
//  Copyright (c) 2014 Tan Tran. All rights reserved.
//

#import "NavigationViewController.h"

/*!
 @class NavigationViewController
*/
@implementation NavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.prarManager = [[PRARManager alloc] initWithSize:self.view.frame.size
                                                delegate:self
                                               showRadar:true];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.locationManager = [appDelegate locationManager];
    self.locationManager.delegate = self;
}

/*!
 @function viewDidAppear
 @abstract Calls [locationManager startUpdatingLocation] for the detailItem (friend). If none, display error view.
 */
- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.detailItem) {
        [self.locationManager startUpdatingLocation];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Error"
                              message: @"There was an error determining the friend to navigate to. Please try again later."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}

/*!
 @function didDismissWithButtonIndex
 @abstract UIAlertViewDelegate implementation. When error alert is dismissed, this function is called. It pops the current VC (goes back).
 */
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [self.navigationController popViewControllerAnimated:YES];
}

/*!
 @function viewWillDisappear
 @abstract Calls [prarManager stopAR].
 */
-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.prarManager stopAR];
    self.didStartAR = false;
}

/*!
 @function didUpdateLocations
 @abstract CLLocationManagerDelegate implementation. When user's location is retrieved,
 this function is called. It starts the AR display with those coordinates.
 */
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

/*!
 @function prarDidSetupAR
 @abstract PRARManagerDelegate implementation. Adds the camera view to screen.
 */
- (void)prarDidSetupAR:(UIView *)arView withCameraLayer:(AVCaptureVideoPreviewLayer *)cameraLayer andRadarView:(UIView *)radar
{
    [self.view.layer addSublayer:cameraLayer];
    [self.view addSubview:arView];
    
    [self.view bringSubviewToFront:[self.view viewWithTag:AR_VIEW_TAG]];
    
    [self.view addSubview:radar];
    
}

/*!
 @function prarUpdateFrame
 @abstract PRARManagerDelegate implementation. Sets AR frame.
 */
- (void)prarUpdateFrame:(CGRect)arViewFrame
{
    [[self.view viewWithTag:AR_VIEW_TAG] setFrame:arViewFrame];
    
}

/*!
 @function prarGotProblem
 @abstract PRARManagerDelegate implementation. Displays error alert.
 */
- (void)prarGotProblem:(NSString*)problemTitle withDetails:(NSString*)problemDetails;
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Error"
                          message: @"There was an error starting the augmented reality display. Please try again later."
                          delegate: self
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
