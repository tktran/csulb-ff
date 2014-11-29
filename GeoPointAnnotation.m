

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
        _subtitle = [LocationTranslation closestBuilding:self.object[@"location"]];
        PFGeoPoint *geoPoint = self.object[@"location"];
        [self setGeoPoint:geoPoint];
    }
    return self;
}

- (void)setGeoPoint:(PFGeoPoint *)geoPoint {
    _coordinate = CLLocationCoordinate2DMake(geoPoint.latitude, geoPoint.longitude);
}

@end
