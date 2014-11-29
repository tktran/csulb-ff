
#import "MapViewController.h"
#import "AppDelegate.h"

@interface FriendsListTableViewController : PFQueryTableViewController <CLLocationManagerDelegate>

- (IBAction)addFriend:(id)sender;
@property (nonatomic, strong) PFQuery *firstQuery;

@end
