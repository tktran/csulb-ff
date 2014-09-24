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

- (IBAction)selectedNextClass:(id)sender
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary *classes = appDelegate.temp_classes;
    NSNumber n = appDelegate.n;
    [classes setObject:n forKey:<#(id<NSCopying>)#>]
     
     ]]self.classNameField.text;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
