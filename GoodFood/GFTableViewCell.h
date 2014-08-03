//
//  GFTableViewCell.h
//  GoodFood
//
//  Created by Ryan Manalo on 7/24/14.
//  Copyright (c) 2014 Manalo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFTableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *addressLabel;
@property (nonatomic, weak) IBOutlet UIImageView *photoImageView;
@property (nonatomic, weak) IBOutlet UIButton *phoneButton;
@property (nonatomic, weak) IBOutlet UIButton *addressButton;
@property (weak, nonatomic) IBOutlet UILabel *openLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoriesLabel;
@property (weak, nonatomic) IBOutlet UIButton *yelpRatingButton;
@property (weak, nonatomic) IBOutlet UIButton *googlePlacesRatingButton;
@property (weak, nonatomic) IBOutlet UILabel *yelpRating;
@property (weak, nonatomic) IBOutlet UILabel *googlePlacesRating;
@end
