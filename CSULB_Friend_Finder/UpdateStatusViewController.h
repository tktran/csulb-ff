//
//  UpdateStatusViewController.h
//  CSULB_Friend_Finder
//
//  Created by Tan Tran on 11/18/14.
//  Copyright (c) 2014 Tan Tran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface UpdateStatusViewController : UIViewController <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *StatusTextField;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@end
