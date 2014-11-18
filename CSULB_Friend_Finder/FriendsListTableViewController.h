
#import "MapViewController.h"
#import "SearchViewController.h"
#import "AppDelegate.h"

@interface FriendsListTableViewController : PFQueryTableViewController <CLLocationManagerDelegate>

- (IBAction)insertCurrentLocation:(id)sender;
@property (nonatomic, strong) PFQuery *firstQuery;

@end
