

#import "AppDelegate.h"
#import "CircleOverlay.h"
#import "GeoQueryAnnotation.h"
#import "GeoPointAnnotation.h"

@interface SearchViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) IBOutlet UISlider *slider;

- (void)setInitialLocation:(CLLocation *)aLocation;

@end
