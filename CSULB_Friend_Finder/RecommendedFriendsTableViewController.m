//
//  FriendsTableViewController.m
//  CSULB_Friend_Finder
//
//  Created by Tan Tran on 9/21/14.
//  Copyright (c) 2014 Tan Tran. All rights reserved.
//

#import "RecommendedFriendsTableViewController.h"

@interface RecommendedFriendsTableViewController ()

@end

@implementation RecommendedFriendsTableViewController
{
    NSMutableArray *friendCellList;
    NSMutableArray *checkedFriends;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.leftBarButtonItem=nil;
    self.navigationItem.hidesBackButton = YES;
    
    FBSession *myFbSession = [PFFacebookUtils session];
    if (myFbSession != nil)
    {
        FBRequest *requestForMyFriends = [FBRequest requestForMyFriends];
        [requestForMyFriends startWithCompletionHandler: ^(FBRequestConnection *connection, id result, NSError *error)
         {
             if(!error)
             {
                 NSArray *resultList = result[@"data"];
                 friendCellList = [[NSMutableArray alloc] init];
                 checkedFriends = [[NSMutableArray alloc] init];
                 for (NSDictionary<FBGraphUser>* result in resultList)
                 {
                     NSDictionary *friend= @{
                                             @"name": result.name,
                                             @"facebookId": result.objectID
                                             };
                     [friendCellList addObject:friend];
                 }
                 [self.tableView reloadData];
             }
         }];
    }
}

/*!
 @function viewDidLoad
 @abstract When view loads, load self.tableView with list of Facebook friends
*/
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem=nil;
    self.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return friendCellList.count;
}

/*!
 @function didSelectRowAtIndexPath
 @abstract When a friend is selected, display an alert showing that a friend request was sent. Send the request.
*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *friend = friendCellList[indexPath.row];

    // Update the image from a + to a check
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:@"check.png"];
    [checkedFriends addObject:[NSNumber numberWithLong:indexPath.row]];
    
    // Make the friend request. Get the objectId of friend that was selected.
    PFObject *friendRequest = [PFObject objectWithClassName:@"FriendRequest"];
    [friendRequest setObject:[PFUser currentUser].objectId forKey:@"RequesterId"];
    
    PFQuery *parseFriendQuery = [PFQuery queryWithClassName:@"_User"];
    [parseFriendQuery whereKey:@"facebookId" equalTo: friend[@"facebookId"]];
    PFObject *parseFriend = [parseFriendQuery getFirstObject];
    [friendRequest setObject:parseFriend.objectId forKey:@"RequesteeId"];
    [friendRequest saveInBackground];
    
    // Display "Friend request sent"jkmjh
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"The friend request was sent." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *friend = friendCellList[indexPath.row];
    cell.textLabel.text = friend[@"name"];
    if ( [checkedFriends containsObject:[NSNumber numberWithLong:indexPath.row]])
        cell.imageView.image = [UIImage imageNamed:@"check.png"];
    else
        cell.imageView.image = [UIImage imageNamed:@"plus.png"];
    return cell;
}
@end
