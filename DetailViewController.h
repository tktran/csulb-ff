//
//  DetailViewController.h
//  Geolocations
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface DetailViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic, strong) PFObject *detailItem;
@property (nonatomic, weak) IBOutlet MKMapView *mapView;

@end
