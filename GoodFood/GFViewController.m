//
//  GFViewController.m
//  GoodFood
//
//  Created by Ryan Manalo on 7/8/14.
//  Copyright (c) 2014 Manalo. All rights reserved.
//

#import "GFViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "GFTableViewController.h"
#import "AnimatedGif.h"


@interface GFViewController ()
@property (strong, nonatomic) UIImageView *loading;
@end

@implementation GFViewController{
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}
@synthesize goodFoodData;




#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        NSString *longitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        NSString *latitude= [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        
        NSLog(@"long: %@, lat: %@", longitude, latitude);
        
        
        // Accessing GoodFood API
        NSString *strURL = [NSString stringWithFormat:@"http://goodfoodwdi.herokuapp.com/results.json?lat=%@&lng=%@", latitude, longitude]; // change screen value
        
        
        _loading.hidden = NO;
        _goodFoodButton.hidden = YES;
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        [manager GET:strURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            
            self.goodFoodData = responseObject;
            
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

            
            GFTableViewController *tableView = (GFTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"table"];
            
            
            [tableView setGoodFoodData:self.goodFoodData];
            
            
            [self.navigationController pushViewController:tableView animated:YES];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
    
    [locationManager stopUpdatingLocation];
    
    // Reverse Geocoding
    NSLog(@"Resolving the Address");
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            NSString *address = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
                                 placemark.subThoroughfare, placemark.thoroughfare,
                                 placemark.postalCode, placemark.locality,
                                 placemark.administrativeArea,
                                 placemark.country];
            
            NSLog(@"address: %@", address);
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    } ];
    
}

- (IBAction)getCurrentLocation:(id)sender {
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    locationManager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];
    
    NSURL *localUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"loading" ofType:@"gif"]];
    _loading = [AnimatedGif getAnimationForGifAtUrl: localUrl];
    
    _loading.frame = CGRectMake(self.view.center.x - 23, self.view.center.y - 23, _loading.image.size.width, _loading.image.size.height);
    [self.view addSubview:_loading];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    _loading.hidden = YES;
    _goodFoodButton.hidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
