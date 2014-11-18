

#import "GeoQueryAnnotation.h"

@implementation GeoQueryAnnotation
@synthesize coordinate = _coordinate;
@synthesize title = _title;
@synthesize subtitle = _subtitle;
@synthesize radius = _radius;


#pragma mark - Initialization

- (id)initWithCoordinate:(CLLocationCoordinate2D)aCoordinate radius:(CLLocationDistance)aRadius {
    self = [super init];
    if (self) {
        _coordinate = aCoordinate;
        _radius = aRadius;

        [self configureLabels];
    }
    return self;
}


#pragma mark - MKAnnotation

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
    _coordinate = newCoordinate;
    [self configureLabels];
}


#pragma mark - ()

- (void)configureLabels {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];

    _title = @"Geo Query";
    
    
    PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:_coordinate.latitude longitude:_coordinate.longitude];
    _subtitle = [LocationTranslation closestBuilding:geoPoint];
}

@end
