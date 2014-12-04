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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Section: %ld, Row: %ld",(long)indexPath.section, (long)indexPath.row);
    if (indexPath.section == 0){
        if (indexPath.row == 0)
        {
            PFUser *user = [PFUser currentUser];
            if ([user[@"privacy"] isEqualToString:@"on"])
            {
                self.privacySwitch.on = false;
                user[@"privacy"] = @"off";
            }
            else // we're turning it on
            {
                self.privacySwitch.on = true;
                user[@"privacy"] = @"on";
            }
            [user saveInBackground];
        }
        else
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
//    [self.parentViewController.navigationController setNavigationBarHidden:YES];
}

-(void) viewWillAppear:(BOOL)animated
{
    PFUser *user = [PFUser currentUser];
    if ([user[@"privacy"] isEqualToString:@"on"])
        self.privacySwitch.on = true;
    else
        self.privacySwitch.on = false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
