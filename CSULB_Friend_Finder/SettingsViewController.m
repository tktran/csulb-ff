//
//  SettingsViewController.m
//  CSULB_Friend_Finder
//
//  Created by Tan Tran on 11/30/14.
//  Copyright (c) 2014 Tan Tran. All rights reserved.
//

#import "SettingsViewController.h"

/*! 
 @class SettingsViewController
 */
@implementation SettingsViewController
- (IBAction)didFlipSwitch:(id)sender {
}

/*!
 @function didSelectRowAtIndexPath
 @abstract Since there are only four rows of settings, manually do separate actions
 for each row: set privacy mode, log out, segue.
*/
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // When a row is selected, do the appropriate action (check manually)
    NSLog(@"Section selected: %ld, Row: %ld",(long)indexPath.section, (long)indexPath.row);
    if (indexPath.section == 0){
        if (indexPath.row == 0) // Switch privacy mode
        {
            PFUser *user = [PFUser currentUser];
            if ([user[@"isOnPrivacyMode"] boolValue])
            {
                self.privacySwitch.on = false;
                user[@"isOnPrivacyMode"] = [NSNumber numberWithBool:NO];
            }
            else // we're turning it on
            {
                self.privacySwitch.on = true;
                user[@"isOnPrivacyMode"] = [NSNumber numberWithBool:YES];
            }
            [user save];
        }
        else // Log out
        {
            [PFUser logOut];
            [self performSegueWithIdentifier:@"logoutSegue" sender:self];
        }
    }
    else{
        if(indexPath.row == 0){
            [self performSegueWithIdentifier:@"changePasswordSegue" sender:self];
        }
        else{
            [self performSegueWithIdentifier:@"changeEmailSegue" sender:self];
        }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void) viewWillAppear:(BOOL)animated
{
    // Upon loading, set privacy switch to correct position
    PFUser *user = [PFUser currentUser];
    
    if ([user[@"isOnPrivacyMode"] boolValue])
        self.privacySwitch.on = true;
    else
        self.privacySwitch.on = false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
