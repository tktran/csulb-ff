//
//  MapViewController.h
//  Geolocations
//
//

#import "AppDelegate.h"
#import "GeoPointAnnotation.h"

/*!
 @class MapViewController
 @discussion This VC displays a map of CSULB with pins for all friends
 of the current user.
*/
@interface MapViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic, strong) PFObject *detailItem;
@property (nonatomic, weak) IBOutlet MKMapView *mapView;

@end
