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
    // Retrieve all buildings
    PFQuery *mapQuery = [PFQuery queryWithClassName:@"Building"];
    NSArray *buildings = [mapQuery findObjects];
    
    // Find the closest building
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
    
    return closestBuildingName;
}

+(BOOL) isOnCSULBCampus: (PFGeoPoint *) geoPoint
{
    double latitude = geoPoint.latitude;
    double longitude = geoPoint.longitude;
    
    BOOL isOnUpperCampus = (latitude > 33.781506f && latitude < 33.788746f) && (longitude > -118.122501f && longitude < -118.107996f);
    BOOL isOnLowerCampus = (latitude > 33.775156f && latitude < 33.781862f) && (longitude > -118.11542f && longitude < -118.111429f);
    return (isOnUpperCampus || isOnLowerCampus);
}


@end
