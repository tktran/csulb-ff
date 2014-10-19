

#import <MapKit/MapKit.h>

@interface SearchViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) IBOutlet UISlider *slider;

- (void)setInitialLocation:(CLLocation *)aLocation;

@end
