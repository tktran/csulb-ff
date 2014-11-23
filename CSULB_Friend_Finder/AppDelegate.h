//
//  AppDelegate.h
//  CSULB_Friend_Finder
//
//  Created by David Garcia on 9/9/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import <FacebookSDK/FacebookSDK.h>
#import <Parse/Parse.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property NSArray *friends;

@property NSString *temp_first_name;
@property NSString *temp_last_name;
@property NSString *temp_email;

@property NSNumber* n;

@property (nonatomic, retain) CLLocationManager *locationManager;

@property BOOL isFacebook;
@end
