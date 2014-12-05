//
//  ChangePasswordViewController.h
//  CSULB_Friend_Finder
//
//  Created by Tan Tran on 12/4/14.
//  Copyright (c) 2014 Tan Tran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"
@interface ChangePasswordViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *nPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@end
