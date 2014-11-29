

#import "AppDelegate.h"
#import "LocationTranslation.h"

/*
 @class GeoPointAnnotation
 @discussion This implementation of MKAnnotation (the iOS class for
 pins on maps) adds functionality to initialize an MKAnnotation
 object directly from a PFUser object:
 * PFUser's location -> MKAnnotation's coordinates
 * PFUser's First+Last names -> MKAnnotation's Title
 * PFUser's approximate location -> MKAnnotation's Subtitle
*/
@interface GeoPointAnnotation : NSObject <MKAnnotation>

- (id)initWithObject:(PFObject *)aObject;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) PFObject *object;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@end
