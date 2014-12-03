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
    // Load the table view with suggestions for friend
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSMutableArray *test = [[NSMutableArray alloc] init];
    test[0] = @"Hello?";
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
