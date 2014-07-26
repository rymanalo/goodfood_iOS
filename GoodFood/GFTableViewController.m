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
    
    cell.nameLabel.text = [self.goodFoodData objectAtIndex:indexPath.row][@"name"];
    
    cell.addressLabel.text = [self.goodFoodData objectAtIndex:indexPath.row][@"address"];
        
    [cell.phoneButton setTitle:[self.goodFoodData objectAtIndex:indexPath.row][@"phone"] forState:UIControlStateNormal];
    cell.phoneButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    cell.addressButton.titleLabel.text = [self.goodFoodData objectAtIndex:indexPath.row][@"coordinates"];
    
    NSString *photo_url = [self.goodFoodData objectAtIndex:indexPath.row][@"photo_url"];
    
    NSString *identifier = [NSString stringWithFormat:@"Cell%i", indexPath.row];
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
//    [self.test setText:[NSString stringWithFormat:@"%@", self.goodFoodData[0][@"name"]]];
    
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
    NSLog(@"was able to load the data %@", self.goodFoodData);
    // Do any additional setup after loading the view.
    _goodFoodTable.delegate = self;
    _goodFoodTable.dataSource = self;
    _goodFoodTable.scrollEnabled = YES;
    
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
