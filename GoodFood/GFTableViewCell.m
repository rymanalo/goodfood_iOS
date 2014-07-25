//
//  GFTableViewCell.m
//  GoodFood
//
//  Created by Ryan Manalo on 7/24/14.
//  Copyright (c) 2014 Manalo. All rights reserved.
//

#import "GFTableViewCell.h"

@implementation GFTableViewCell
@synthesize nameLabel;
@synthesize addressLabel;
@synthesize photoImageView;
@synthesize phoneButton;


- (IBAction)addressButtonPushed:(id)sender {
    // Look up address
}


- (IBAction)phoneButtonPushed:(UIButton *)sender {
    // Call Number
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
