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

@property (strong, nonatomic) PFObject *detailItem;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (weak, nonatomic) IBOutlet UIButton *pokeButton;
@property (weak, nonatomic) IBOutlet UIButton *findYourFriendButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *updateButton;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
