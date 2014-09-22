//
//  LoginViewController.h
//  CSULB_Friend_Finder
//
//  Created by Tan Tran on 9/19/14.
//  Copyright (c) 2014 Tan Tran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <FacebookSDK/FacebookSDK.h>
#import "AppDelegate.h"

@interface LoginViewController : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>


@end
