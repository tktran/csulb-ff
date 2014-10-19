//
//  DetailViewController.h
//  Geolocations
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ProfileViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic, strong) PFObject *detailItem;
@property (nonatomic, weak) IBOutlet MKMapView *mapView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@end
