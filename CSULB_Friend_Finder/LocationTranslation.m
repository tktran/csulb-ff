//
//  LocationTranslation.m
//  CSULB_Friend_Finder
//
//  Created by Tan Tran on 11/18/14.
//  Copyright (c) 2014 Tan Tran. All rights reserved.
//

#import "LocationTranslation.h"

@implementation LocationTranslation




+(NSString*) closestBuilding: (PFGeoPoint*) sourceLoc
{
    PFQuery *mapQuery = [PFQuery queryWithClassName:@"Building"];
    
    NSArray *buildings = [mapQuery findObjects];
    double minDistance = INFINITY;
    NSString *closestBuildingName = @"nowhere";

    for (PFObject *building in buildings) {
        PFGeoPoint *buildingPoint = building[@"location"];
        double distance = [buildingPoint distanceInKilometersTo:sourceLoc];
        if (distance < minDistance)
        {
            minDistance = distance;
            closestBuildingName = building[@"name"];
        }
    }
    NSString *aroundString = [NSString stringWithFormat:@"Around %@", closestBuildingName];
    return aroundString;
}
@end
