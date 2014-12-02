//
//  UserInfoViewController.h
//  CSULB_Friend_Finder
//
//  Created by Tan Tran on 9/23/14.
//  Copyright (c) 2014 Tan Tran. All rights reserved.
//

#import "AppDelegate.h"

/*!
 @class This VC asks for the First Name, Last Name, and email of
 the about-to-be user.
*/
@interface UserInfoViewController : UIViewController <UITextFieldDelegate>

/*!
 @property firstNameField
 @abstract Text field for first name of the user signing up.
*/
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;

/*!
 @property lastNameField
 @abstract Text field for last name of the user signing up.
 */
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;

/*!
 @property emailField
 @abstract Text field for email address of the user signing up.
 */
@property (weak, nonatomic) IBOutlet UITextField *emailField;

@end
