//
//  TabBarViewController.m
//  CSULB_Friend_Finder
//
//  Created by Nick Colburn on 10/1/14.
//  Copyright (c) 2014 Nick Colburn. All rights reserved.
//

#import "TabBarViewController.h"

@implementation TabBarViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    self.navigationItem.hidesBackButton = YES;
    [self setSelectedIndex:0];
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
}

@end
