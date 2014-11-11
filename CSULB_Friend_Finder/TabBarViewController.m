//
//  TabBarViewController.m
//  CSULB_Friend_Finder
//
//  Created by Nick Colburn on 10/1/14.
//  Copyright (c) 2014 Nick Colburn. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    self.navigationItem.leftBarButtonItem=nil;
    self.navigationItem.hidesBackButton = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        // Row selection
//        [segue.destinationViewController setDetailItem:object];
    } else if ([segue.identifier isEqualToString:@"showSearch"]) {
        // Search button
//        [segue.destinationViewController setInitialLocation:self.locationManager.location];
    }
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