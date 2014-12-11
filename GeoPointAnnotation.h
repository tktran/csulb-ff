

#import "AppDelegate.h"
#import "LocationTranslation.h"

/*!
 @class GeoPointAnnotation
 @discussion This implementation of MKAnnotation (the iOS class for
 pins on maps) adds functionality to initialize an MKAnnotation
 object directly from a PFUser object:
 * PFUser's location -> MKAnnotation's coordinates
 * PFUser's First+Last names -> MKAnnotation's Title
 * PFUser's approximate location -> MKAnnotation's Subtitle
*/
@interface GeoPointAnnotation : NSObject <MKAnnotation>

/*!
 @function initWithObject
 @abstract Initialize using a PFUser's name and coordinates.
 @discussion The PFUser's First+Names become Annotation title.
    Their approximate building locatoin becomes Annotation subtitle.
    Their PFGeoPoint location becomes Annotation coordinate.
 @param aObject
    The PFUser to make an annotation from
*/
- (id)initWithObject:(PFUser *)aUser;

/*!
 @property coordinate
 @abstract Coordinates of the annotation to add to map
*/
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

/*!
 @property object
 @abstract The PFUser used to initialize this GeoPointAnnotation
*/
@property (nonatomic, strong) PFObject *object;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@end
