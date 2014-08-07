//
//  GFTableViewCell.m
//  GoodFood
//
//  Created by Ryan Manalo on 7/24/14.
//  Copyright (c) 2014 Manalo. All rights reserved.
//

#import "GFTableViewCell.h"
#import <MapKit/MapKit.h>

@implementation GFTableViewCell
@synthesize nameLabel;
@synthesize addressLabel;
@synthesize photoImageView;
@synthesize phoneButton;



- (BOOL)isYelpInstalled {
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"yelp5.3:"]];
}

- (IBAction)yelpRatingButtonPushed:(id)sender {
    // Look up restaurant's Yelp page in Yelp App if available. In Safari if not available
    if ([self isYelpInstalled]) {
        // Call into the Yelp app
        NSArray *yelpBiz = [self.yelpRatingButton.titleLabel.text componentsSeparatedByString:@"/"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"yelp5.3:///biz/%@", yelpBiz[4]]]];
    } else {
        // Use the Yelp touch site
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.yelpRatingButton.titleLabel.text]];
    }
}

- (IBAction)googlePlacesRatingButtonPushed:(id)sender {
    // Look up restaurant's Google Places page in Safari.
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.googlePlacesRatingButton.titleLabel.text]];
}

- (IBAction)addressButtonPushed:(id)sender {
    // Look up address in Maps. Enable navigation to restaurant.
    
    NSArray *coordinates = [self.addressButton.titleLabel.text componentsSeparatedByString:@","];
    
    CLLocationCoordinate2D rdOfficeLocation = CLLocationCoordinate2DMake([coordinates[0] floatValue],[coordinates[1] floatValue]);
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:rdOfficeLocation addressDictionary:nil];
    MKMapItem *item = [[MKMapItem alloc] initWithPlacemark:placemark];
    item.name = self.nameLabel.text;
    [item openInMapsWithLaunchOptions:nil];
    
}


- (IBAction)phoneButtonPushed:(UIButton *)sender {
    // Call Phone number
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", self.phoneButton.titleLabel.text]]];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
