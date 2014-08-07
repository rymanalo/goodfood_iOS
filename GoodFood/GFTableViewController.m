//
//  GFTableViewController.m
//  GoodFood
//
//  Created by Ryan Manalo on 7/8/14.
//  Copyright (c) 2014 Manalo. All rights reserved.
//

#import "GFTableViewController.h"
#import "GFViewController.h"
#import "GFTableViewCell.h"


@interface GFTableViewController ()
@property (strong ,nonatomic) NSMutableDictionary *cachedImages;

@end

@implementation GFTableViewController
@synthesize goodFoodData;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"goodFoodTableCell";
    
    GFTableViewCell *cell = (GFTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"goodFoodTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    // Restaurant name
    cell.nameLabel.text = [self.goodFoodData objectAtIndex:indexPath.row][@"name"];
    
    // Yelp categories
    cell.categoriesLabel.text = [self.goodFoodData objectAtIndex:indexPath.row][@"categories"];
    
    
    // If address is available, nicely print out in label
    NSArray *addressWords = [[self.goodFoodData objectAtIndex:indexPath.row][@"address"] componentsSeparatedByString:@","];
    
    if ([addressWords[0] isEqualToString:@"Not available"]) {
        cell.addressLabel.text = [self.goodFoodData objectAtIndex:indexPath.row][@"coordinates"];
    } else {
        if (addressWords.count == 3) {
            cell.addressLabel.text = [NSString stringWithFormat:@" %@,\n%@,%@", addressWords[0], addressWords[1], addressWords[2]];
        } else if (addressWords.count == 2) {
            cell.addressLabel.text = [NSString stringWithFormat:@" %@,%@", addressWords[0], addressWords[1]];
        }

    }
    
    
    // Restaurant phone number
    [cell.phoneButton setTitle:[self.goodFoodData objectAtIndex:indexPath.row][@"phone"] forState:UIControlStateNormal];
    cell.phoneButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    
    // Hide coordines in button title.
    cell.addressButton.titleLabel.text = [self.goodFoodData objectAtIndex:indexPath.row][@"coordinates"];

    
    // Display whether or not the retsaurant is open.
    if ([[NSString stringWithFormat:@"%@", [self.goodFoodData objectAtIndex:indexPath.row][@"open"]] isEqualToString:@"Not available"]) {
        cell.openLabel.textColor = [UIColor colorWithRed:235.0f/255.0f green:30.0f/255.0f blue:35.0f/255.0f alpha:1.0f];
        cell.openLabel.text = @"N/A";
    } else if ([[self.goodFoodData objectAtIndex:indexPath.row][@"open"] intValue] == 0) {
        cell.openLabel.textColor = [UIColor colorWithRed:235.0f/255.0f green:30.0f/255.0f blue:35.0f/255.0f alpha:1.0f];
        cell.openLabel.text = @"CLOSED";
    } else if ([[self.goodFoodData objectAtIndex:indexPath.row][@"open"] intValue] == 1) {
        cell.openLabel.textColor = [UIColor colorWithRed:49.0f/255.0f green:199.0f/255.0f blue:49.0f/255.0f alpha:1.0f];
        cell.openLabel.text = @"OPEN";
    }
    
    // First photo from Google Places if available. Cache the photos to be able to load pictures faster when scrolling through the table.
    NSString *photo_url = [self.goodFoodData objectAtIndex:indexPath.row][@"photo_url"];
    
    NSString *identifier = [NSString stringWithFormat:@"Cell%i", (int)indexPath.row];
    if([self.cachedImages objectForKey:identifier] != nil){
        cell.photoImageView.image = [self.cachedImages valueForKey:identifier];
    }else{
        
        char const * s = [identifier  UTF8String];
        dispatch_queue_t queue = dispatch_queue_create(s, 0);
        
        dispatch_async(queue, ^{
            
            NSURL *imageURL = [NSURL URLWithString:photo_url];
            
            NSData *imageData = [NSData alloc];
            if ([photo_url isEqualToString:@"nophoto.png"]) {
                imageData = UIImagePNGRepresentation([UIImage imageNamed:photo_url]);
            } else {
                imageData = [[NSData alloc] initWithContentsOfURL:imageURL];
            }
            
            UIImage *img = nil;
            img = [[UIImage alloc] initWithData:imageData];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if ([tableView indexPathForCell:cell].row == indexPath.row) {
                    [self.cachedImages setValue:img forKey:identifier];
                    cell.photoImageView.image = [self.cachedImages valueForKey:identifier];
                }
            });
        });
    }
    
    // Yelp rating
    if ([self.goodFoodData objectAtIndex:indexPath.row][@"yelp_rating"]) {
        [cell.yelpRatingButton setTitle:[self.goodFoodData objectAtIndex:indexPath.row][@"yelp_url"] forState:UIControlStateNormal];
        cell.yelpRating.text = [[self.goodFoodData objectAtIndex:indexPath.row][@"yelp_rating"] stringValue];
    }

    // Google Places rating (if available)
    if ([self.goodFoodData objectAtIndex:indexPath.row][@"google_rating"] != (id)[NSNull null]) {
        [cell.googlePlacesRatingButton setTitle:[self.goodFoodData objectAtIndex:indexPath.row][@"google_places_url"]  forState:UIControlStateNormal];
        cell.googlePlacesRating.text = [NSString stringWithFormat:@"%@", [self.goodFoodData objectAtIndex:indexPath.row][@"google_rating"]];
    }

    // Total Yelp reviews
    cell.reviewCountLabel.text = [[self.goodFoodData objectAtIndex:indexPath.row][@"review_count"] stringValue];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIView* separatorBottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 149, 320, 1)];
    separatorBottomLineView.backgroundColor = [UIColor colorWithRed:150.0f/255.0f green:150.0f/255.0f blue:150.0f/255.0f alpha:1.0f];
    [cell.contentView addSubview:separatorBottomLineView];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.goodFoodData count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
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
    NSLog(@"passed data: %@", self.goodFoodData);
    // Do any additional setup after loading the view.
    _goodFoodTable.delegate = self;
    _goodFoodTable.dataSource = self;
    _goodFoodTable.scrollEnabled = YES;
    _goodFoodTable.backgroundColor = [UIColor colorWithRed:246.0/255.0f green:246.0/255.0f blue:246.0/255.0f alpha:1.0f];
    
    self.cachedImages = [[NSMutableDictionary alloc] init];
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
