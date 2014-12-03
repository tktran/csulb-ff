//
//  AddFriendViewController.h
//  CSULB_Friend_Finder
//
//  Created by Tan Tran on 11/30/14.
//  Copyright (c) 2014 Tan Tran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


/*!
 @class AddFriendViewController
 @abstract Adds a friend from their email address or real name.
*/
@interface AddFriendViewController : PFQueryTableViewController

/*!
 @property tableView
 @abstract Table to display search results (from searching by real name or email)
*/
@property (weak, nonatomic) IBOutlet UITextField *searchFriendTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) NSMutableArray *queryResults;
@end
