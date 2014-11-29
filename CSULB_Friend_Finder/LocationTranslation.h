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

/*!
 @class LocationTranslation
 @discussion The closestBuilding function implemented by this interface
 returns a string "Around ____", where ____ is the closest CSULB
 building to the given coordinates. e.g., "Around Hall of Science".
*/
@interface LocationTranslation : NSObject
+(NSString*) closestBuilding: (PFGeoPoint*) sourceLoc;
@end
