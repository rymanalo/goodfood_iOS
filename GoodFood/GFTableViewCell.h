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
@end
