
#import "MapViewController.h"
#import "SearchViewController.h"
#import "AppDelegate.h"

@interface FriendsListTableViewController : PFQueryTableViewController <CLLocationManagerDelegate>

@property (nonatomic, retain) CLLocationManager *locationManager;

- (IBAction)insertCurrentLocation:(id)sender;

@end
