//
//  FBInfoViewController.m
//  CSULB_Friend_Finder
//
//  Created by Tan Tran on 9/23/14.
//  Copyright (c) 2014 Tan Tran. All rights reserved.
//

#import "FBInfoViewController.h"

@interface FBInfoViewController ()
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;

@end

@implementation FBInfoViewController

- (IBAction)clickedSubmitButton:(id)sender {
    if (self.firstNameField.text.length == 0 ||
        self.lastNameField.text.length == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Try again" message:@"Please fill in the First and Last Name fields." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
//        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
//        appDelegate.temp_first_name = self.firstNameField.text;
//        appDelegate.temp_last_name = self.lastNameField.text;
        
        FBSession *myFbSession = [PFFacebookUtils session];
        if( myFbSession.isOpen)
        {
            [self performSegueWithIdentifier: @"recommendedFriendsSegue" sender: sender];
        }
        else
        {
            [self performSegueWithIdentifier: @"FBInfoSegue" sender: sender];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];

    FBSession *myFbSession = [PFFacebookUtils session];
    if( myFbSession.isOpen )
    {
        FBRequest *request = [FBRequest requestForMe];
        [request startWithCompletionHandler: ^(FBRequestConnection *connection, id result, NSError *error)
         {
             if (error)
             {
                 NSLog(@"%@", error);
             }
             else
             {
                 PFUser *user = [PFUser currentUser];
                 [user setObject:result[@"first_name"] forKey:@"first_name"];
                 [user setObject:result[@"last_name"] forKey:@"last_name"];
                 [user setObject:result[@"email"] forKey:@"email"];

                 [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                     if (!error)
                     {
                         // Hooray! Let them use the app now.
                         NSLog(@"User Info:\n%@\n%@\n%@", user[@"first_name"],user[@"last_name"],user[@"email"]);
                     }
                     else
                     {
                         NSString *errorString = [error userInfo][@"Error pushing to parse"];
                         NSLog(@"%@", errorString);
                     }
                 }];
             }
         }];
    }
    else
    {
        NSLog(@"Error no FB connection.");
    }
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
