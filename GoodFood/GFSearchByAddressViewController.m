//
//  GFSearchByAddressViewController.m
//  GoodFood
//
//  Created by Ryan Manalo on 8/21/14.
//  Copyright (c) 2014 Manalo. All rights reserved.
//

#import "GFSearchByAddressViewController.h"
#import "SPGooglePlacesAutocompleteQuery.h"
#import "SPGooglePlacesAutocompletePlace.h"
#import "AFHTTPRequestOperationManager.h"
#import "GFTableViewController.h"
#import "AnimatedGif.h"

@interface GFSearchByAddressViewController ()
@property (nonatomic) NSArray *places;
@property (strong, nonatomic) UIImageView *loading;

@end

@implementation GFSearchByAddressViewController
@synthesize goodFoodData;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"searchResult";
    
    UITableViewCell *cell = [_searchResultsTable dequeueReusableCellWithIdentifier:simpleTableIdentifier];
//    if (cell == nil)
//    {
//        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"goodFoodTableCell" owner:self options:nil];
//        cell = [nib objectAtIndex:0];
//    }
    SPGooglePlacesAutocompletePlace *place = _places[indexPath.row];
    [place resolveToPlacemark:^(CLPlacemark *placemark, NSString *addressString, NSError *error) {
        if (placemark) {
            NSLog(@"\nCoordinates: (%f, %f)\nAddress: %@", placemark.location.coordinate.latitude, placemark.location.coordinate.longitude, addressString);
            
            cell.textLabel.text = addressString;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"lat=%f&lng=%f", placemark.location.coordinate.latitude, placemark.location.coordinate.longitude];
            cell.detailTextLabel.alpha = 0;
        }
        
    }];
    
    
//    UIView* separatorBottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 149, 320, 1)];
//    separatorBottomLineView.backgroundColor = [UIColor colorWithRed:150.0f/255.0f green:150.0f/255.0f blue:150.0f/255.0f alpha:1.0f];
//    [cell.contentView addSubview:separatorBottomLineView];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    _loading.hidden = NO;
    
    _searchResultsTable.alpha = 0.33;
    _searchResultsTable.userInteractionEnabled = NO;
    
    UITableViewCell *cell = (UITableViewCell *)[_searchResultsTable cellForRowAtIndexPath:indexPath];
    
//    NSString *address = cell.textLabel.text;
    NSString *coordinates = cell.detailTextLabel.text;
    
    NSString *strURL = [NSString stringWithFormat:@"http://goodfoodwdi.herokuapp.com/results.json?%@", coordinates];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _places.count;
}


- (IBAction)queryInput:(id)sender {
    SPGooglePlacesAutocompleteQuery *query = [SPGooglePlacesAutocompleteQuery query];
    query.input = _addressTextfield.text;
    query.radius = 100.0;
    query.language = @"en";
    query.types = SPPlaceTypeGeocode;
    
    if (_addressTextfield.text.length > 5) {
        [query fetchPlaces:^(NSArray *places, NSError *error) {
            _places = [[NSArray alloc] initWithArray:places];
            [_searchResultsTable reloadData];
            
        }];
    }

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _searchResultsTable.delegate = self;
    _searchResultsTable.dataSource = self;
    _searchResultsTable.scrollEnabled = YES;
    _searchResultsTable.backgroundColor = [UIColor colorWithRed:246.0/255.0f green:246.0/255.0f blue:246.0/255.0f alpha:1.0f];
    
    _addressTextfield.returnKeyType = UIReturnKeyDone;

    
    NSURL *localUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"loading" ofType:@"gif"]];
    _loading = [AnimatedGif getAnimationForGifAtUrl: localUrl];
    
    _loading.frame = CGRectMake(self.view.center.x - 23, self.view.center.y - 23, _loading.image.size.width, _loading.image.size.height);
    _loading.alpha = 0.33;
    [self.view addSubview:_loading];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    _loading.hidden = YES;
    _searchResultsTable.userInteractionEnabled = YES;
    _searchResultsTable.alpha = 1;
    
    [_addressTextfield becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
