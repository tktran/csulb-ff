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
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        appDelegate.temp_first_name = self.firstNameField.text;
        appDelegate.temp_last_name = self.lastNameField.text;
        
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
    if( myFbSession.isOpen)
    {
        self.firstNameField.text = appDelegate.temp_first_name;
        self.lastNameField.text = appDelegate.temp_last_name;
    }
    else
    {
        self.firstNameField.text = @"";
        self.lastNameField.text = @"";
    }
    self.navigationItem.hidesBackButton = YES;

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
