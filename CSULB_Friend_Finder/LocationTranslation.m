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
    [mapQuery setLimit:1000];
    
    NSArray *objects = [mapQuery findObjects];
    double minDistance = INFINITY;
    NSString *closestBuildingName = @"None";

    for (PFObject *object in objects) {
        PFGeoPoint *buildingPoint = object[@"location"];
        double distance = [buildingPoint distanceInKilometersTo:sourceLoc];
        if (distance < minDistance)
        {
            minDistance = distance;
            closestBuildingName = object[@"name"];
        }
    }
    NSString *aroundString = [NSString stringWithFormat:@"Around %@", closestBuildingName];
    return aroundString;
}
@end
