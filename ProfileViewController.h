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

/*!
 @property detailItem
 @abstract User to display, passed in the segue to this VC
*/
@property (strong, atomic) PFObject *detailItem;

/*!
 @property mapView
 @abstract Map displaying the user as a pin
*/
@property (weak, atomic) IBOutlet MKMapView *mapView;

/*!
 @property pokeButton
 @abstract Button to send a poke to the user displayed in this profile. Hidden if profile is showing current user.
*/
@property (weak, atomic) IBOutlet UIButton *pokeButton;

/*!
 @property findYourFriendButton
 @abstract Button to navigate to the user displayed in this profile. Hidden if profile is showing current user.
*/
@property (weak, atomic) IBOutlet UIButton *findYourFriendButton;

/*!
 @property statusLabel
 @abstract Text label showing the user's current status.
*/
@property (weak, atomic) IBOutlet UILabel *statusLabel;

/*!
 @property nameLabel
 @abstract Text label showing the user's First Name + Last Name
*/
@property (weak, atomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *lastUpdatedLabel;

@end
