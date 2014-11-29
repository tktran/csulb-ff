//
//  LoginViewController.h
//  CSULB_Friend_Finder
//
//  Created by Tan Tran on 9/19/14.
//  Copyright (c) 2014 Tan Tran. All rights reserved.
//

#import "AppDelegate.h"

/*! 
 @class LoginViewController
 @discussion This VC displays the login screen (username, password, submit) and signup buttons.
*/
@interface LoginViewController : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>


@end
