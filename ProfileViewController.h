//
//  DetailViewController.h
//  Geolocations
//
//

#import "AppDelegate.h"
#import "GeoPointAnnotation.h"

@interface ProfileViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic, strong) PFObject *detailItem;
@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@end
