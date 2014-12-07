//
//  UserInfoViewController.m
//  CSULB_Friend_Finder
//
//  Created by Tan Tran on 9/23/14.
//  Copyright (c) 2014 Tan Tran. All rights reserved.
//

#import "UserInfoViewController.h"

@implementation UserInfoViewController

/*!
 @function clickedSubmitButton
 @discussion sdflk
*/
- (IBAction)clickedSubmitButton:(id)sender {
    if (self.firstNameField.text.length == 0 ||
        self.lastNameField.text.length == 0 ||
        self.emailField.text.length == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Try again" message:@"Please fill in the First Name, Last Name, and Email fields." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        PFUser *user = [PFUser currentUser];
        user[@"first_name"] = self.firstNameField.text;
        user[@"last_name"] = self.lastNameField.text;
        user[@"email"] = self.emailField.text;
        user[@"status"] = @"I just joined CSULB FF!";
        user[@"isOnPrivacyMode"] = [NSNumber numberWithBool:NO];
        user[@"location"] = [PFGeoPoint geoPointWithLatitude:37.7873589F longitude:122.408227F];
        [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error)
            {
                FBSession *myFbSession = [PFFacebookUtils session];
                if( myFbSession.isOpen)
                {
                    [self performSegueWithIdentifier: @"recommendedFriendsSegue" sender: sender];
                }
                else
                {
                    [self performSegueWithIdentifier: @"homeSegue" sender: sender];
                }
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message: @"There was an error submitting your info. Please wait a moment and try again."
                                                               delegate: nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }
        }];
    }
    [self.firstNameField resignFirstResponder];
    [self.lastNameField resignFirstResponder];
}

// Method to dismiss keyboard when touching screen
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    self.navigationItem.leftBarButtonItem=nil;
    self.navigationItem.hidesBackButton = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem=nil;
    self.navigationItem.hidesBackButton = YES;

    FBSession *myFbSession = [PFFacebookUtils session];
    if (myFbSession != nil)
    {
        if(!myFbSession.isOpen)
        {
            [FBSession openActiveSessionWithAllowLoginUI:NO];
        }
        FBRequest *request = [FBRequest requestForMe];
        [request startWithCompletionHandler: ^(FBRequestConnection *connection, id result, NSError *error)
         {
             if (error)
             {
                 NSLog(@"%@", error);
             }
             else
             {
                 // Populate text fields with the retrieved FB info, if applicable
                 self.firstNameField.text = result[@"first_name"];
                 self.lastNameField.text = result[@"last_name"];
                 self.emailField.text = result[@"email"];
             }
         }];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
