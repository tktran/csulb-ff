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

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Section: %ld, Row: %ld",(long)indexPath.section, (long)indexPath.row);
    if (indexPath.section == 0){
        if(indexPath.row == 0){
            [PFUser logOut];
            [self performSegueWithIdentifier:@"logoutSegue" sender:self];
        }else{}
    }
    else{}
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
