//
//  UpdateStatusViewController.m
//  CSULB_Friend_Finder
//
//  Created by Tan Tran on 11/18/14.
//  Copyright (c) 2014 Tan Tran. All rights reserved.
//

#import "UpdateStatusViewController.h"

@interface UpdateStatusViewController ()

@end

@implementation UpdateStatusViewController
BOOL didHitSubmitButton;

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [_StatusTextField becomeFirstResponder];
}

- (IBAction)didSubmitStatus:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message: @"There was an error updating your status. Please try again later."
                                                   delegate: nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];

    PFUser *user = [PFUser currentUser];
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error)
    {
        if (!error)
        {
            user[@"status"] = self.StatusTextField.text;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
