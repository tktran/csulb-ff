//
//  SettingsViewController.h
//  CSULB_Friend_Finder
//
//  Created by Tan Tran on 11/30/14.
//  Copyright (c) 2014 Tan Tran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


/*! @class SettingsViewController
 @abstract Toggles privacy mode, logs out, or change password/email.
*/
@interface SettingsViewController : UITableViewController <UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UISwitch *privacySwitch;

@end
