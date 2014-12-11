//
//  UpdateStatusViewController.m
//  CSULB_Friend_Finder
//
//  Created by Tan Tran on 11/18/14.
//  Copyright (c) 2014 Tan Tran. All rights reserved.
//

#import "UpdateStatusViewController.h"

/*!
 @class UpdateStatusViewController
*/
@implementation UpdateStatusViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [_statusTextField becomeFirstResponder];
}

- (IBAction)didSubmitStatus:(id)sender {
    // alert to show if error; not shown yet
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message: @"There was an error updating your status. Please try again later."
                                                   delegate: nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];

    // Get the current geoPoint and save it
    PFUser *user = [PFUser currentUser];
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error)
    {
        if (!error)
        {
            user[@"status"] = self.statusTextField.text;
            user[@"location"] = geoPoint;
            [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error)
                    [self.navigationController popViewControllerAnimated:YES];
                else
                {
                    [alert show];
                }
            }];
        }
        else
        {
            [alert show];
        }
    }];
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
