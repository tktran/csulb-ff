
#import "MapViewController.h"
#import "AppDelegate.h"

/* 
 @class This VC is a table view displaying all friends
 of the current user. Each cell displays the First Name +
 Last Name as title and approximate building location as
 subtitle.
*/
@interface FriendsListTableViewController : PFQueryTableViewController <CLLocationManagerDelegate>

@property (nonatomic, strong) PFQuery *firstQuery;

@end
