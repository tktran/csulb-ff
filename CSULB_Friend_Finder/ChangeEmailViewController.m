//
//  ChangeEmailViewController.m
//  CSULB_Friend_Finder
//
//  Created by Tan Tran on 12/4/14.
//  Copyright (c) 2014 Tan Tran. All rights reserved.
//

#import "ChangeEmailViewController.h"

@interface ChangeEmailViewController ()

@end

@implementation ChangeEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clickedSubmitButton:(id)sender
{
    PFUser *user = [PFUser currentUser];
    NSString *currentEmail = user[@"email"];
    // 
    if ([currentEmail isEqualToString:self.oldEmailTextField.text])
    {
        user[@"email"] = self.nEmailTextField.text;
        [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error && succeeded)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Your email was changed!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
                else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure" message:@"There was an error. Please try again later." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure" message:@"You entered the incorrect old email address." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}
@end
