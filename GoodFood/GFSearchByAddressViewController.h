//
//  GFSearchByAddressViewController.h
//  GoodFood
//
//  Created by Ryan Manalo on 8/21/14.
//  Copyright (c) 2014 Manalo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFSearchByAddressViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    
    NSMutableArray *goodFoodData;
    
}
@property (nonatomic, retain) NSMutableArray *goodFoodData;
@property (weak, nonatomic) IBOutlet UITextField *addressTextfield;
@property (weak, nonatomic) IBOutlet UITableView *searchResultsTable;
@end
