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

@interface NavigationViewController : UIViewController <PRARManagerDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) PFObject *detailItem;
@property (nonatomic, strong) PRARManager *manager;
@property (nonatomic) BOOL didStartAR;

@end
