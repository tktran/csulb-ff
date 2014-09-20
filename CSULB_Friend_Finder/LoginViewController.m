//
//  LoginViewController.m
//  CSULB_Friend_Finder
//
//  Created by Tan Tran on 9/19/14.
//  Copyright (c) 2014 Tan Tran. All rights reserved.
//

#import "LoginViewController.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;

@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@end

@implementation LoginViewController
/*- (IBAction)userLogin:(id)sender {
    [PFUser logInWithUsernameInBackground: self.usernameField.text password:self.passwordField.text
        block:^(PFUser *user, NSError *error)
    {
        if (user) {
        // Do stuff after successful login.
        } else {
        // The login failed. Check error to see why.
        }
    }];
}*/

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //if (![PFUser currentUser]) { // No user logged in
        // Create the log in view controller
        PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
        [logInViewController setDelegate:self]; // Set ourselves as the delegate
        logInViewController.fields = PFLogInFieldsUsernameAndPassword
         | PFLogInFieldsLogInButton
         | PFLogInFieldsSignUpButton
         | PFLogInFieldsPasswordForgotten
         | PFLogInFieldsDismissButton
         | PFLogInFieldsFacebook;
    
    logInViewController.facebookPermissions = @[@"public_profile", @"user_friends"];
    
        // Create the sign up view controller
        PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
        [signUpViewController setDelegate:self]; // Set ourselves as the delegate
        
        
        // Assign our sign up controller to be displayed from the login controller
        [logInViewController setSignUpController:signUpViewController];
        
        // Present the log in view controller
        [self presentViewController:logInViewController animated:YES completion:NULL];
   // }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    ///////////////////////////////////////////////////////////////
    //self.view.backgroundColor = [UIColor colorWithPatternImage://
    //[UIImage imageNamed:@"myBackgroundImage.png"]];            //
    //label.text = @"My Logo";                                   //
    //[label sizeToFit];                                         //
    //self.logInView.logo = label; // logo can be any UIView     //
    ///////////////////////////////////////////////////////////////
    
   
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
