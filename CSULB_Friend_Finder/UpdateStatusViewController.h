//
//  UpdateStatusViewController.h
//  CSULB_Friend_Finder
//
//  Created by Tan Tran on 11/18/14.
//  Copyright (c) 2014 Tan Tran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

/*!
 @class This VC contains a text box for the user to enter a new
 status. Upon pressing the Submit button of this VC, this new status
 and the user's location will be pushed to Parse.
*/
@interface UpdateStatusViewController : UIViewController <CLLocationManagerDelegate>

/*!
 @property statusTextField
 @abstract 140-character status to update one's profile with
 */
@property (weak, nonatomic) IBOutlet UITextView *statusTextField;

@end
