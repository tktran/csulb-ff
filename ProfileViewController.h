//
//  DetailViewController.h
//  Geolocations
//
//

#import "AppDelegate.h"
#import "GeoPointAnnotation.h"

/*!
 @class ProfileViewController
 @abstract Displays a user's profile.
 @discussion This VC displays a user's profile, with map pin, name, and
 status. Buttons displayed differ depending on whether the user being
 displayed is the current user or a friend.
*/
@interface ProfileViewController : UIViewController <MKMapViewDelegate>

@property (strong, atomic) PFObject *detailItem;
@property (weak, atomic) IBOutlet MKMapView *mapView;

@property (weak, atomic) IBOutlet UIButton *pokeButton;
@property (weak, atomic) IBOutlet UIButton *findYourFriendButton;
@property (weak, atomic) IBOutlet UIBarButtonItem *updateButton;

@property (weak, atomic) IBOutlet UILabel *statusLabel;
@property (weak, atomic) IBOutlet UILabel *nameLabel;

@end
