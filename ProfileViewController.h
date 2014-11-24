//
//  DetailViewController.h
//  Geolocations
//
//

#import "AppDelegate.h"
#import "GeoPointAnnotation.h"

@interface ProfileViewController : UIViewController <MKMapViewDelegate>

@property (strong, nonatomic) PFObject *detailItem;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIButton *pokeButton;
@property (weak, nonatomic) IBOutlet UIButton *findYourFriendButton;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

- (void) updateDisplayInfo;
- (void) updateRightButton;
@end
