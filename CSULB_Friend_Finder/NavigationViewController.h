//
//  NavigationViewController.h
//  CSULB_Friend_Finder
//
//  Created by Tan Tran on 11/16/14.
//  Copyright (c) 2014 Tan Tran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRARManager.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"

/*!
 @class NavigationViewController
 @discussion This view controller launches the PRAR view as soon as possible
 upon loading. It does so by retrieving the system-wide locationManager and
 calling locationManager.startUpdatingLocations. When the current location
 is finally retrieved, this VC's didUpdateLocations method will be called with
 the current location. That method will launch PRAR with those coordinates.
 */
@interface NavigationViewController : UIViewController <PRARManagerDelegate, CLLocationManagerDelegate>

/*!
 @property detailItem
 @discussion Item passed to this VC in its segue. It is the user (PFObject) to navigate to.
*/
@property (nonatomic, strong) PFObject *detailItem;

/*!
 @property prarManager
 @discussion The PRAR manager, with methods to start and stop the AR display.
*/
@property (nonatomic, strong) PRARManager *prarManager;

/*!
 @property locationManager
 @discussion The location manager to get current coordinates from. Assigned by
 retrieving the reference to the system-wide locationManager from appDelegate.
*/
@property (nonatomic, strong) CLLocationManager *locationManager;

/*! 
 @property didStartAR
 @discussion Set within didUpdateLocations, after calling prarManager.didStartAR.
 Needed because didUpdateLocations may be called multiple times by iOS, but the
 AR display should only be launched once.
*/
@property (nonatomic) BOOL didStartAR;

@end
