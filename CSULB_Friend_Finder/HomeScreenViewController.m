//
//  HomeScreenViewController.m
//  CSULB_Friend_Finder
//
//  Created by Gustavo Yepes on 9/24/14.
//  Copyright (c) 2014 Gustavo Yepes. All rights reserved.
//

#import "HomeScreenViewController.h"

@interface HomeScreenViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *classLabel;
@property (weak, nonatomic) IBOutlet UILabel *friendsLabel;

@end

@implementation HomeScreenViewController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    self.navigationItem.leftBarButtonItem=nil;
    self.navigationItem.rightBarButtonItem.style = UIBarButtonSystemItemAdd;
    self.navigationItem.rightBarButtonItem.enabled = YES;
    self.navigationItem.hidesBackButton = YES;
}

-(void) updateTextLabels {
    // Allows current view controller's nav bar to show
    [self.parentViewController.navigationController setNavigationBarHidden:YES];
    
    PFUser *user = [PFUser currentUser];
    self.nameLabel.text = [NSString stringWithFormat:@"Welcome, %@ %@",user[@"first_name"], user[@"last_name"]];
    NSLog(@"%@", user[@"last_name"]);
    
    NSMutableDictionary *classes = [[NSMutableDictionary alloc] initWithDictionary: user[@"temp_classes"]];
    NSString *classLabelString = @"Your clases are:\n";
    for (id key in classes)
    {
        NSArray *array = [classes objectForKey:key];
        
        NSString *classLocation = array[0];
        classLabelString = [classLabelString stringByAppendingString:@"\u2022"];
        classLabelString = [classLabelString stringByAppendingString:key];
        
        classLabelString = [classLabelString stringByAppendingString:@" at "];
        classLabelString = [classLabelString stringByAppendingString:classLocation];
        
        classLabelString = [classLabelString stringByAppendingString:@" at "];
        NSString *classTime = array[1];
        classLabelString = [classLabelString stringByAppendingString:classTime];
        classLabelString = [classLabelString stringByAppendingString:@"\n"];
    }
    self.classLabel.text = classLabelString;
    
    
    PFGeoPoint *geoPoint = user[@"location"];
    NSString *string = [NSString stringWithFormat:@"Your location is: %.2f, %.2f", geoPoint.latitude, geoPoint.longitude];
    self.locationLabel.text = string;
    
    //    self.classLabel.numberOfLines = 0;
    //
    //    UILabel *label = self.classLabel;
    //    CGSize labelSize = [label.text sizeWithFont:label.font
    //                              constrainedToSize:label.frame.size
    //                                  lineBreakMode:label.lineBreakMode];
    //    label.frame = CGRectMake(
    //                             label.frame.origin.x, label.frame.origin.y,
    //                             label.frame.size.width, labelSize.height);

}
- (IBAction)updateLocation:(id)sender {
    // If it's not possible to get a location, then return.
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    CLLocation *location = appDelegate.locationManager.location;
    if (!location) {
        return;
    }
    
    // Configure the new event with information from the location.
    CLLocationCoordinate2D coordinate = [location coordinate];
    PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    PFUser *user = [PFUser currentUser];
    [user setObject:geoPoint forKey:@"location"];
    
    [user saveEventually:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // Reload the PFQueryTableViewController
            [self updateTextLabels];
        }
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateTextLabels];
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
