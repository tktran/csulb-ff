//
//  RegisterViewController.m
//  CSULB_Friend_Finder
//
//  Created by Tan Tran on 9/19/14.
//  Copyright (c) 2014 Tan Tran. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UILabel *validSubmitMsg;

@end

@implementation RegisterViewController
- (IBAction)submitRegistration:(id)sender
{
    //Below PFObject might need to be PFUsers
    PFUser *user = [PFUser user];
    user.username = self.usernameField.text;
    user.password = self.passwordField.text;
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // Hooray! Let them use the app now.
        } else {
            NSString *errorString = [error userInfo][@"error"];
            NSLog(@"%@", errorString);
            // Show the errorString somewhere and let the user try again.
        }
    }];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
