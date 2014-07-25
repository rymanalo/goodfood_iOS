//
//  GFTableViewController.h
//  GoodFood
//
//  Created by Ryan Manalo on 7/8/14.
//  Copyright (c) 2014 Manalo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    
    NSMutableArray *goodFoodData;
}

@property (nonatomic , retain) NSMutableArray *goodFoodData;
@property (weak, nonatomic) IBOutlet UITableView *goodFoodTable;
@end
