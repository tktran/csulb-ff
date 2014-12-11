
#import "MapViewController.h"
#import "AppDelegate.h"

/*!
 @class FriendsListTableViewController
 @abstract Displays all user's friends.
 @discussionThis VC is a table view displaying all friends
 of the current user. Each cell displays the First Name +
 Last Name as title and approximate building location as
 subtitle.
*/
@interface FriendsListTableViewController : PFQueryTableViewController <CLLocationManagerDelegate>

@end
