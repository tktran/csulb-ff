

#import "GeoPointAnnotation.h"

@interface GeoPointAnnotation()
@end

@implementation GeoPointAnnotation


#pragma mark - Initialization

- (id)initWithObject:(PFObject *)aObject {
    self = [super init];
    if (self) {
        _object = aObject;
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
