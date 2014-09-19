//
//  RootViewController.h
//  CSULB_Friend_Finder
//
//  Created by David Garcia on 9/9/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AWSiOSSDKv2/DynamoDB.h>


@interface RootViewController : UIViewController <UIPageViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;

@end
