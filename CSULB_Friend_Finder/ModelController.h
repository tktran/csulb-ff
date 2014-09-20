//
//  ModelController.h
//  CSULB_Friend_Finder
//
//  Created by David Garcia on 9/9/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#
#import <UIKit/UIKit.h>
#import "FacebookSDK/FacebookSDK.h"
#import "Parse/Parse.h"

@class DataViewController;

@interface ModelController : NSObject <UIPageViewControllerDataSource>


@property (weak, nonatomic) IBOutlet FBLoginView *loginView;

- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(DataViewController *)viewController;

@end
