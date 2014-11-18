//
//  LocationTranslation.h
//  CSULB_Friend_Finder
//
//  Created by Tan Tran on 11/18/14.
//  Copyright (c) 2014 Tan Tran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "Parse/Parse.h"

@interface LocationTranslation : NSObject
+(NSString*) closestBuilding: (PFGeoPoint*) sourceLoc;
@end
