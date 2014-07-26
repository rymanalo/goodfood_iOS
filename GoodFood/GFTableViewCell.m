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

- (IBAction)addressButtonPushed:(id)sender {
    // Look up address
    
    NSArray *coordinates = [self.addressButton.titleLabel.text componentsSeparatedByString:@","];
    
    CLLocationCoordinate2D rdOfficeLocation = CLLocationCoordinate2DMake([coordinates[0] floatValue],[coordinates[1] floatValue]);
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:rdOfficeLocation addressDictionary:nil];
    MKMapItem *item = [[MKMapItem alloc] initWithPlacemark:placemark];
    item.name = self.nameLabel.text;
    [item openInMapsWithLaunchOptions:nil];
    
    
    NSLog(@"coordinates: %@", coordinates);
}


- (IBAction)phoneButtonPushed:(UIButton *)sender {
    // Call Phone number
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", self.phoneButton.titleLabel.text]]];

    NSLog(@"button phone #: %@", self.phoneButton.titleLabel.text);
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
