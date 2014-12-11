//
//  AppDelegate.m
//  CSULB_Friend_Finder
//
//  Created by David Garcia on 9/9/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "AppDelegate.h"

/*!
 @class AppDelegate
*/
@implementation AppDelegate
@synthesize locationManager = _locationManager;

/*!
 @function didFinishLaunchingWithOptions
 @abstract Upon app launch, register with Parse and for push notifications if not already.
*/
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [FBLoginView class];
    [Parse setApplicationId:@"7Ung08OGNSgz6A0NDXTXRiMtXGvKGDpjhPWmOWaC"
                  clientKey:@"UTkEQ1cFDmSDrjg8QOiXEyADnK0LQ5csknDqIApN"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    [PFFacebookUtils initializeFacebook];
    
    // Register for Push Notitications, if running iOS 8
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |UIUserNotificationTypeBadge |UIUserNotificationTypeSound);
    
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:    userNotificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    }
    else
    {
        // Register for Push Notifications before iOS 8
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |UIRemoteNotificationTypeAlert |UIRemoteNotificationTypeSound)];
    }
    
    return YES;
}

/*!
 @function didRegisterForRemoteNotificationsWithDeviceToken
 @abstract Upon successful registration for notifications, save the token of this iOS device to Parse servers.
 Notifications will be targeted to this device based on its token.
*/
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation setObject:[PFUser currentUser] forKey:@"user"];
    [currentInstallation saveInBackground];
}

/*!
 @function didReceiveRemoteNotification
 @abstract When a notification is received, let Parse handle it: literally, [PFPush handlePush]
*/
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
}

/*!
 @function openURL
 @abstract Utility function used to open Facebook login URL
*/
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication withSession:[PFFacebookUtils session]];
}

/*!
 @function locationManager
 @abstract Get reference to app-wide location manager singleton
*/
- (CLLocationManager *)locationManager {
    if (_locationManager != nil) {
        return _locationManager;
    }
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [_locationManager startUpdatingLocation];
    return _locationManager;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

/*!
 @function applicationDidBecomeActive
 @abstract Upon loading the app from its icon or opening it back up from the background, activate the current Facebook session, and check for friend requests.
*/
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [FBAppCall handleDidBecomeActiveWithSession:[PFFacebookUtils session]];
    
    // Check for friend requests upon starting up
    PFUser *user = [PFUser currentUser];
    if (user != nil)
    {
        PFQuery *query = [PFQuery queryWithClassName:@"FriendRequest"];
        [query whereKey:@"RequesteeId" equalTo:user.objectId];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            for (PFObject *request in objects)
            {
                PFQuery *requesterQuery = [PFUser query];
                PFObject *requester = [requesterQuery getObjectWithId:request[@"RequesterId"]];
                
                self.requesterId = requester.objectId;
                NSString *requestMessage = [NSString stringWithFormat:@"%@ %@ sent you a friend request!", requester[@"first_name"], requester[@"last_name"]];
                UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"Request" message:requestMessage delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
                [view addButtonWithTitle:@"Accept"];
                [view addButtonWithTitle:@"Ignore"];
                [view show];
                
                [request deleteInBackground];
            }
        }];
    }
    
    // Update the user's location
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        if (!error)
        {
            PFUser *user = [PFUser currentUser];
            user[@"location"] = geoPoint;
            [user saveInBackground];
        }
    }];
}

/*!
 @function clickedButtonAtIndex
 @abstract Implementation of UIAlertView interface. When a friend request is received, clicking on "Accept" or "Ignore" calls this function.
 This function then adds the friend if Accept, does nothing if Ignore.
*/
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0)
    {
        PFObject *friendship = [PFObject objectWithClassName:@"Friendship"];
        friendship[@"Friend1_Id"] = [PFUser currentUser].objectId;
        friendship[@"Friend2_Id"] = self.requesterId;
        [friendship saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error)
                NSLog(@"Friendship1 error: %@", error);
        }];
        
        PFObject *friendship2 = [PFObject objectWithClassName:@"Friendship"];
        friendship2[@"Friend2_Id"] = [PFUser currentUser].objectId;
        friendship2[@"Friend1_Id"] = self.requesterId;
        [friendship2 saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error)
                NSLog(@"Friendship2 error: %@", error);
        }];
    }
    else
    {
        // Ignore friend request
    }
}

/*!
 @function applicationWillTerminate
 @abstract Per standard practice, close the current Facebook session when app is explicitly exited.
*/
- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[PFFacebookUtils session] close];
}

@end
