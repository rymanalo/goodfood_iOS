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
    
    NSURL *imageURL = [NSURL URLWithString:[self.goodFoodData objectAtIndex:indexPath.row][@"photo_url"]];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    cell.photoImageView.image = [UIImage imageWithData:imageData];

    cell.addressLabel.text = [self.goodFoodData objectAtIndex:indexPath.row][@"address"];
        
    [cell.phoneButton setTitle:[self.goodFoodData objectAtIndex:indexPath.row][@"phone"] forState:UIControlStateNormal];
    cell.phoneButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
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
