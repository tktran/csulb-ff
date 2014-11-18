//
//  NavigationViewController.h
//  CSULB_Friend_Finder
//
//  Created by Tan Tran on 11/16/14.
//  Copyright (c) 2014 Tan Tran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRARManager.h"

@interface NavigationViewController : UIViewController <PRARManagerDelegate>
@property (nonatomic, strong) PRARManager *manager;


@end
