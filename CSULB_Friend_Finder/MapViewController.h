//
//  MapViewController.h
//  Geolocations
//
//

#import "AppDelegate.h"
#import "GeoPointAnnotation.h"

@interface MapViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic, strong) PFObject *detailItem;
@property (nonatomic, weak) IBOutlet MKMapView *mapView;

@end
