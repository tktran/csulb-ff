//
//  MapViewController.h
//  Geolocations
//
//

#import "AppDelegate.h"
#import "GeoPointAnnotation.h"

/*!
 @class MapViewController
 @abstract This VC displays a map of CSULB with pins for all friends
 of the current user.
*/
@interface MapViewController : UIViewController <MKMapViewDelegate>

/*!
 @property detailItem
 @abstract User to display, passed in the segue to this VC
 */
@property (nonatomic, strong) PFObject *detailItem;

/*!
 @property mapView
 @abstract Map displaying all friends as pins
 */
@property (nonatomic, weak) IBOutlet MKMapView *mapView;

@end
