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
    // Do any additional setup after loading the view, typically from a nib.
    
    self.manager = [[PRARManager alloc] initWithSize:self.view.frame.size delegate:self showRadar:true];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    CLLocationCoordinate2D locationCoordinates = CLLocationCoordinate2DMake(33.782674, -118.108972);
    
    [self.manager startARWithData:[self getDummyData] forLocation:locationCoordinates];
}


#pragma mark - Dummy data
-(NSArray *)getDummyData{
    NSArray *dummyData = @[
                           @{
                               @"id" : @(0),
                               @"lat" : @(33.785063F),
                               @"lon" : @(-118.112F),
                               @"title" : @"Prospector"
                               },
                           @{
                               @"id" : @(1),
                               @"lat" : @(33.781046F),
                               @"lon" : @(-118.111105F),
                               @"title" : @"Gustavo"
                               },
                           @{
                               @"id" : @(2),
                               @"lat" : @(33.785928F),
                               @"lon" : @(-118.114712F),
                               @"title" : @"Miguel"
                               }
                           ];
    return dummyData;
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
