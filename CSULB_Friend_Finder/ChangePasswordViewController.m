//
//  ChangePasswordViewController.m
//  CSULB_Friend_Finder
//
//  Created by Tan Tran on 12/4/14.
//  Copyright (c) 2014 Tan Tran. All rights reserved.
//

#import "ChangePasswordViewController.h"

@implementation ChangePasswordViewController

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
    // If the new password is equal to the confirmation of the new password
    if ([self.nPasswordTextField.text isEqualToString:self.confirmPasswordTextField.text])
    {
        PFUser *user = [PFUser currentUser];
        NSString *oldPassword = self.oldPasswordTextField.text;
        
        // We can't do string comparison on the salted old password, so we must check it
        // by logging in with the password
        [PFUser logInWithUsernameInBackground:user.username password:oldPassword block:^(PFUser *user, NSError *error) {
            if (!error) // correct password
            {
                user.password = self.nPasswordTextField.text;
                [user saveInBackground];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Your password was changed!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"An error occurred. Try again later." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }];
    }
    else
    {
        // confirm didn't match
    }
}
@end
