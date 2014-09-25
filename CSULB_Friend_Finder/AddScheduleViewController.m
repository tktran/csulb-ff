//
//  AddScheduleViewController.m
//  CSULB_Friend_Finder
//
//  Created by Tan Tran on 9/23/14.
//  Copyright (c) 2014 Tan Tran. All rights reserved.
//

#import "AddScheduleViewController.h"

@interface AddScheduleViewController ()
@property (weak, nonatomic) IBOutlet UITextField *classNameField;
@property (weak, nonatomic) IBOutlet UITextField *locationField;
@property (weak, nonatomic) IBOutlet UITextField *timeField;

@end

@implementation AddScheduleViewController

- (IBAction)clickedNextClassButton:(id)sender
{
    if (self.classNameField.text.length == 0 ||
        self.locationField.text.length == 0 ||
        self.timeField.text.length == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Try again" message:@"Please fill in all fields." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else // successful entry of class fields
    {
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        NSMutableDictionary *classes = appDelegate.temp_classes;
        if (classes == nil)
            classes = [[NSMutableDictionary alloc] init];
            
        NSString *className = self.classNameField.text;
        NSString *location = self.locationField.text;
        NSString *time = self.timeField.text;

        NSMutableArray *myClassValues = [[NSMutableArray alloc] init];
        myClassValues[0] = location;
        myClassValues[1] = time;
        
        [classes setObject:myClassValues forKey:className];
        
        self.classNameField.text = @"";
        self.locationField.text = @"";
        self.timeField.text = @"";
        
        NSLog(@"%lu", (unsigned long)classes.count);
        appDelegate.temp_classes = classes;
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;

    // Do any additional setup after loading the view.
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
