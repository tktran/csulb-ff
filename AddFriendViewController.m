//
//  AddFriendViewController.m
//  CSULB_Friend_Finder
//
//  Created by Tan Tran on 12/4/14.
//  Copyright (c) 2014 Tan Tran. All rights reserved.
//

#import "AddFriendViewController.h"

@interface AddFriendViewController ()

@end

@implementation AddFriendViewController

-(PFQuery*) queryForTable
{
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    return query;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", object[@"first_name"], object[@"last_name"]];
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFUser *currentUser = [PFUser currentUser];
    PFObject *userToAdd = [self objectAtIndexPath:indexPath];
    PFObject *friendRequest = [PFObject objectWithClassName:@"FriendRequest"];
    friendRequest[@"RequesterId"] = currentUser.objectId;
    friendRequest[@"RequesteeId"] = userToAdd.objectId;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
