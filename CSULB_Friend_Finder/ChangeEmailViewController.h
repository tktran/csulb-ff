//
//  ChangeEmailViewController.h
//  CSULB_Friend_Finder
//
//  Created by Tan Tran on 12/4/14.
//  Copyright (c) 2014 Tan Tran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"

@interface ChangeEmailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *oldEmailTextField;
@property (weak, nonatomic) IBOutlet UITextField *nEmailTextField;

@end
