//
//  LoginViewController.m
//  CSULB_Friend_Finder
//
//  Created by Tan Tran on 9/19/14.
//  Copyright (c) 2014 Tan Tran. All rights reserved.
//

#import "LoginViewController.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*!
 @function didLogInUser
 @method Once user logs in, segue to the main iOS application tabs.
*/
-(void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user
{
    [self performSegueWithIdentifier:@"loginSegue" sender:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*!
 @function didSignupUser
 @method Once user finishes signing up with Parse controller (which asks for username+password, or Facebook login for Facebook logins),
 go to CSULB FF sign up controller (which asks for First Name, Last Name, and Email).
*/
- (void) signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user
{
    [self performSegueWithIdentifier:@"signUpSegue" sender:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*!
 @function viewDidAppear
 @abstract When view appears, load the PFLoginViewController
*/
-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"LoginViewController:viewDidAppear()");
    [super viewDidAppear:animated];
    
    // Create the log in view controller
    if(![PFUser currentUser])
    {
        NSLog(@"LoginViewController:viewDidAppear(): ![PFUser currentUser]");
        PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
        [logInViewController setDelegate:self]; // Set ourselves as the delegate
        logInViewController.fields = PFLogInFieldsUsernameAndPassword
            | PFLogInFieldsLogInButton
            | PFLogInFieldsSignUpButton
            | PFLogInFieldsPasswordForgotten
            | PFLogInFieldsDismissButton
            | PFLogInFieldsFacebook;
        
        logInViewController.logInView.logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
        [logInViewController.logInView.logo setFrame:CGRectMake(16.0f, 43.0f, 288.0f, 60.0f)];
        
        logInViewController.facebookPermissions = @[@"public_profile", @"user_friends", @"email"];
        
        // Create the sign up view controller
        PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
        [signUpViewController setDelegate:self]; // Set ourselves as the delegate
        signUpViewController.signUpView.logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
        signUpViewController.fields = PFSignUpFieldsDefault
            | PFSignUpFieldsUsernameAndPassword
            | PFSignUpFieldsSignUpButton
            | PFSignUpFieldsDismissButton;
        [signUpViewController.signUpView.logo setFrame:CGRectMake(16.0f, 43.0f, 288.0f, 60.0f)];
        
        // Assign our sign up controller to be displayed from the login controller
        [logInViewController setSignUpController:signUpViewController];
        
        // Present the log in view controller
        [self presentViewController:logInViewController animated:YES completion:NULL];
    }

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if([PFUser currentUser] != nil)
    {
        [self performSegueWithIdentifier:@"loginSegue" sender:self];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        // Remain on this view, the PFLoginView
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
