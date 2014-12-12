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
 @discussion When submit button is clicked, check for correct length of text fields, then save to Parse database
*/
- (IBAction)clickedSubmitButton:(id)sender {
    // If field(s) incomplete, show alert
    if (self.firstNameField.text.length == 0 ||
        self.lastNameField.text.length == 0 ||
        self.emailField.text.length == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Try again" message:@"Please fill in the First Name, Last Name, and Email fields." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else // Else, save their entered info + default status, privacy, and location fields
    {
        PFUser *user = [PFUser currentUser];
        user[@"first_name"] = self.firstNameField.text;
        user[@"last_name"] = self.lastNameField.text;
        user[@"email"] = self.emailField.text;
        user[@"status"] = @"I just joined CSULB FF!";
        user[@"isOnPrivacyMode"] = [NSNumber numberWithBool:NO];
        user[@"location"] = [PFGeoPoint geoPointWithLatitude:33.779274F longitude:-118.114343F];
        user[@"facebookId"] = @"";
        
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
        
        if ([PFFacebookUtils session] != nil)
        {
            FBRequest *request = [FBRequest requestForMe];
            [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                if (!error)
                {
                    NSDictionary<FBGraphUser> *friend = (NSDictionary<FBGraphUser>*) result;
                    user[@"facebookId"] = friend.objectID;
                    [user saveInBackground];
                }
            }];
        }

    }
    [self.firstNameField resignFirstResponder];
    [self.lastNameField resignFirstResponder];
}

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

/*!
 @function viewDidLoad
 @abstract When view loads, if sign up is with Facebook, populate the First Name, Last Name, and Email
 fields with Facebook info.
*/
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
