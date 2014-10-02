//
//  FriendsTableViewController.m
//  CSULB_Friend_Finder
//
//  Created by Tan Tran on 9/21/14.
//  Copyright (c) 2014 Tan Tran. All rights reserved.
//

#import "FriendsTableViewController.h"

@interface FriendsTableViewController ()

@end

@implementation FriendsTableViewController
{
    NSArray *friendsList;
    NSMutableArray *myCheckedFriends;
}

- (IBAction) performSegue:(id)sender {
    [self performSegueWithIdentifier:@"ShowDetail" sender:sender];}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    friendsList = appDelegate.friends;
    myCheckedFriends = [[NSMutableArray alloc] init];
//    myCheckedFriends = appDelegate.checkedFriends;
    
    NSLog(@"%lu", friendsList.count);
    
    self.navigationItem.hidesBackButton = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return friendsList.count;
}

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
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"The friend request was sent." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];

    [alert show];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
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

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UIView *footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
//    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
//    [button setTitle:@"Next" forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(performSegue:) forControlEvents:UIControlEventTouchUpInside];
//    button.frame=CGRectMake(0, 0, 130, 30); //set some large width to ur title
//    [footerView addSubview:button];
//    return footerView;
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
