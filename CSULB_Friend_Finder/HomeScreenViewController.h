//
//  HomeScreenViewController.h
//  CSULB_Friend_Finder
//
//  Created by Gustavo Yepes on 9/24/14.
//  Copyright (c) 2014 Gustavo Yepes. All rights reserved.
//

#import "AppDelegate.h"

@interface HomeScreenViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *nameLabel;
@property (weak, nonatomic) IBOutlet UITextView *locationLabel;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;


@end
