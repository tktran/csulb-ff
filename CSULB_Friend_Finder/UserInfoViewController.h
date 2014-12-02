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
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;

@end
