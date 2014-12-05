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

/*! 
 @class AppDelegate
 @discussion This class implements methods for the UIApplication objects. 
 These objects handle app-wide tasks such as: startup, shutdown, going
 into background, and registering for the ability to display notifications.
*/
@interface AppDelegate : UIResponder <UIApplicationDelegate, UIAlertViewDelegate>

    /*!
     @property window
     @discussion This is a default object. It manages the views an app displays
     on the window screen, with methods to: get the UIScreen, get the root
     view controller, do coordinate conversions, and others.
    */
    @property (strong, nonatomic) UIWindow *window;

    /*!
     @property locationManager
     @discussion This object encapsulates methods to get the current location, to
     start updating it, stop updating it, etc. It is contained here, in AppDelegate,
     so that it can be "global" to the app. Any views that wish to use location
     services retrieve this manager from AppDelegate.
    */
    @property (nonatomic, retain) CLLocationManager *locationManager;

@property (nonatomic, retain) NSString *requesterId;
@end
