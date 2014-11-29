//
//  DetailViewController.h
//  Geolocations
//
//

#import "AppDelegate.h"
#import "GeoPointAnnotation.h"

/*!
 @class ProfileViewController
 @discussion This VC displays a user's profile, with map pin, name, and
 status. Buttons displayed differ depending on whether the user being
 displayed is the current user or a friend.
*/
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
