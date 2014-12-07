#import "GeoPointAnnotation.h"

@implementation GeoPointAnnotation

#pragma mark - Initialization

- (id)initWithObject:(PFUser *)aUser {
    self = [super init];
    if (self) {
        _object = aUser;
        _title = [NSString stringWithFormat: @"%@ %@", self.object[@"first_name"], self.object[@"last_name"]];
        if ([LocationTranslation isOnCSULBCampus:_object[@"location"]])
        {
            _subtitle = [NSString stringWithFormat:@"Around %@", [LocationTranslation closestBuilding:self.object[@"location"]]];;
        }
        else
        {
            _subtitle = nil;
        }
        PFGeoPoint *geoPoint = self.object[@"location"];
        [self setGeoPoint:geoPoint];
    }
    return self;
}

- (void)setGeoPoint:(PFGeoPoint *)geoPoint {
    _coordinate = CLLocationCoordinate2DMake(geoPoint.latitude, geoPoint.longitude);
}

@end
