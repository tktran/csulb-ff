//
//  UserInfoViewController.m
//  CSULB_Friend_Finder
//
//  Created by Tan Tran on 9/23/14.
//  Copyright (c) 2014 Tan Tran. All rights reserved.
//

#import "UserInfoViewController.h"

@interface UserInfoViewController ()
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;

@end

@implementation UserInfoViewController

- (IBAction)clickedSubmitButton:(id)sender {
    if (self.firstNameField.text.length == 0 ||
        self.lastNameField.text.length == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Try again" message:@"Please fill in the First and Last Name fields." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        PFUser *user = [PFUser currentUser];
        [user setObject:self.firstNameField.text forKey:@"first_name"];
        [user setObject:self.lastNameField.text forKey:@"last_name"];
        [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error)
            {
                // Hooray! Let them use the app now.
            }
            else
            {
                NSString *errorString = [error userInfo][@"Error pushing to parse"];
                NSLog(@"%@", errorString);
            }
        }];
        
        FBSession *myFbSession = [PFFacebookUtils session];
        if( myFbSession.isOpen)
        {
            [self performSegueWithIdentifier: @"recommendedFriendsSegue" sender: sender];
        }
        else
        {
            [self performSegueWithIdentifier: @"userInfoSegue" sender: sender];
        }
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
//    FBRequest *requestForMyFriends = [FBRequest requestForMyFriends];
//    [requestForMyFriends startWithCompletionHandler: ^(FBRequestConnection *connection, id result, NSError *error)
//     {
//         if(!error)
//         {
//             NSArray * resultList = [result objectForKey:@"data"];
//             NSMutableArray *mutableFriends = [[NSMutableArray alloc] init];
//             for (NSDictionary<FBGraphUser>* result in resultList)
//             {
//                 NSString *realName = result.name;
//                 NSLog(@"%@", realName);
//                 [mutableFriends addObject:realName];
//             }
//             AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
//             appDelegate.friends = [NSArray arrayWithArray:mutableFriends];
//             NSLog(@"%lu", appDelegate.friends.count);
//         }
//     }];
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
             PFUser *user = [PFUser currentUser];
             // Removed so the user can use what's written in the text field
//             [user setObject:result[@"first_name"] forKey:@"first_name"];
//             [user setObject:result[@"last_name"] forKey:@"last_name"];
             [user setObject:result[@"email"] forKey:@"email"];

             [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                 if (!error)
                 {
                     // Hooray! Let them use the app now.
                 }
                 else
                 {
                     NSString *errorString = [error userInfo][@"Error pushing to parse"];
                     NSLog(@"%@", errorString);
                 }
             }];
             
             // Populate text fields with the retrieved FB info, if applicable
             self.firstNameField.text = result[@"first_name"];
             self.lastNameField.text = result[@"last_name"];
         }
     }];
    
    FBRequest *requestForMyFriends = [FBRequest requestForMyFriends];
    [requestForMyFriends startWithCompletionHandler: ^(FBRequestConnection *connection, id result, NSError *error)
     {
         if(!error)
         {
             NSArray * resultList = [result objectForKey:@"data"];
             NSMutableArray *mutableFriends = [[NSMutableArray alloc] init];
             for (NSDictionary<FBGraphUser>* result in resultList)
             {
                 NSString *realName = result.name;
                 NSLog(@"%@", realName);
                 [mutableFriends addObject:realName];
             }
             AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
             appDelegate.friends = [NSArray arrayWithArray:mutableFriends];
             NSLog(@"%lu", appDelegate.friends.count);
         }
     }];
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
