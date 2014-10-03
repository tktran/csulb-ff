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

-(void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user
{
    NSLog(@"LoginViewController:didLogInUser()");
    if(user.isNew)
    {
        NSLog(@"LoginViewController:didLogInUser(): user.isNew");
        [self performSegueWithIdentifier:@"fbSignUpSegue" sender:self];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        NSLog(@"LoginViewController:didLogInUser(): !user.isNew");
        [self performSegueWithIdentifier:@"loginSegue" sender:self];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void) signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user
{
    NSLog(@"LoginViewController:didSignUpUser()");
    [self performSegueWithIdentifier:@"fbSignUpSegue" sender:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController
{
    NSLog(@"LoginViewController:didCancelLogIn()");
    [self dismissViewControllerAnimated:YES completion:nil];
}

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
        [signUpViewController.signUpView.logo setFrame:CGRectMake(16.0f, 43.0f, 288.0f, 60.0f)];
        
        // Assign our sign up controller to be displayed from the login controller
        [logInViewController setSignUpController:signUpViewController];
        
        // Present the log in view controller
        [self presentViewController:logInViewController animated:YES completion:NULL];
    }

}

- (void)viewDidLoad
{
    NSLog(@"LoginViewController:viewDidLoad()");
    [super viewDidLoad];
//    [PFUser logOut];
    if([PFUser currentUser] != nil)
    {
        // Not sure if we need this, or if it was just for demo pruposes
//        FBRequest *request = [FBRequest requestForMe];
//        [request startWithCompletionHandler: ^(FBRequestConnection *connection, id result, NSError *error)
//         {
//             if(!error)
//             {
//                 NSDictionary *userData = (NSDictionary *)result;
//                 _NameLabel.adjustsFontSizeToFitWidth = NO;
//                 _NameLabel.numberOfLines = 0;
//                 NSString *name = [@"Welcome, " stringByAppendingString:userData[@"name"]];
//                 name = [name stringByAppendingString:@"\nYou logged in."];
//                 _NameLabel.text = name;
//                 
//                 // not sure if should get delegate stuff here
//                 AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
//                 appDelegate.temp_first_name = userData[@"first_name"];
//                 
//                 appDelegate.temp_last_name = userData[@"last_name"];
//                 appDelegate.temp_email = userData[@"email"];
//                 [self performSegueWithIdentifier:@"loginSegue" sender:self];
//                 [self dismissViewControllerAnimated:YES completion:nil];
//             }
//         }];
        
        [self performSegueWithIdentifier:@"loginSegue" sender:self];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
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
