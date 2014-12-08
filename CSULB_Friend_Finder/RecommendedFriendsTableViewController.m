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
    NSArray *friendsList;
    NSMutableArray *myCheckedFriends;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.leftBarButtonItem=nil;
    self.navigationItem.hidesBackButton = YES;
}

/*!
 @function viewDidLoad
 @abstract When view loads, load self.tableView with list of Facebook friends
*/
- (void)viewDidLoad {
    [super viewDidLoad];
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
                 NSArray *resultList = [result objectForKey:@"data"];
                 NSMutableArray *mutableFriends = [[NSMutableArray alloc] init];
                 for (NSDictionary<FBGraphUser>* result in resultList)
                 {
                    
                     NSString *realName = result.name;
                     [mutableFriends addObject:realName];
                 }
                 friendsList = [NSArray arrayWithArray:mutableFriends];
                 [self.tableView reloadData];
             }
         }];
    }
    myCheckedFriends = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return friendsList.count;
}

/*!
 @function didSelectRowAtIndexPath
 @abstract When a friend is selected, display an alert showing that a friend request was sent. Send the request.
*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1. Add this friend to the list of selected friends
    // (ones that already got a friend request)
    NSLog(@"Selected row: %lu", indexPath.row); // you can see selected row number in your console;
    NSString *friend = friendsList[ indexPath.row ];
    [myCheckedFriends addObject:friend];
    
    // 2. Update the image from a + to a check
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:@"check.png"];
    
    // 3. Display "Friend request sent"
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"The friend request was sent. But not really." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];

    // Make the friend request
    PFObject *friendRequest = [PFObject objectWithClassName:@"FriendRequest"];
    friendRequest[@"RequesterId"] = [PFUser currentUser].objectId;
    friendRequest[@"RequesteeId"] = 0; // @TODO
    [friendRequest saveInBackground];

    [alert show];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = friendsList[indexPath.row];
    
    if ([myCheckedFriends containsObject:[friendsList objectAtIndex:indexPath.row]])
    {
        cell.imageView.image = [UIImage imageNamed:@"check.png"];
    }
    else
    {
        cell.imageView.image = [UIImage imageNamed:@"plus.png"];
    }
    return cell;
}
@end
