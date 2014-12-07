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
    PFQuery *friendshipQuery = [PFQuery queryWithClassName:@"Friendship"];
    PFQuery *finalQuery = [PFQuery queryWithClassName:@"_User"];
    [finalQuery whereKey:@"objectId" doesNotMatchKey:@"Friend1_Id" inQuery:friendshipQuery];
    [finalQuery whereKey:@"objectId" notEqualTo:[PFUser currentUser].objectId];
    return finalQuery;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", object[@"first_name"], object[@"last_name"]];
    cell.imageView.image = [UIImage imageNamed:@"plus.png"];
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFUser *currentUser = [PFUser currentUser];
    PFObject *userToAdd = [self objectAtIndexPath:indexPath];
    
    PFObject *friendRequest = [PFObject objectWithClassName:@"FriendRequest"];
    friendRequest[@"RequesterId"] = currentUser.objectId;
    friendRequest[@"RequesteeId"] = userToAdd.objectId;
    [friendRequest saveInBackground];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:@"check.png"];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Request sent!" message:@"Your friend request was sent!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
