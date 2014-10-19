

#import <CoreLocation/CoreLocation.h>
#import <Parse/Parse.h>

@interface MasterViewController : PFQueryTableViewController <CLLocationManagerDelegate>

@property (nonatomic, retain) CLLocationManager *locationManager;

- (IBAction)insertCurrentLocation:(id)sender;

@end
