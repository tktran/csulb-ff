//
//  AddFriendViewController.m
//  CSULB_Friend_Finder
//
//  Created by Tan Tran on 11/30/14.
//  Copyright (c) 2014 Tan Tran. All rights reserved.
//

#import "AddFriendViewController.h"

/*!
 @class AddFriendViewController
 */
@implementation AddFriendViewController

- (IBAction)finishedEnteringFriendNameOrEmail:(id)sender
{
    ;
}

-(PFQuery*) queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query whereKey:@"username" equalTo:self.searchFriendTextField.text];
    return query;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *) user
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = user.objectId;
    return cell;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.searchFriendTextField becomeFirstResponder];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
//    // Do any additional setup after loading the view.
//    NSMutableArray *test = [[NSMutableArray alloc] init];
//    test[0] = @"Hello?";
//    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
