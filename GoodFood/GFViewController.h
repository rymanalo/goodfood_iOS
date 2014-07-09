//
//  GFViewController.h
//  GoodFood
//
//  Created by Ryan Manalo on 7/8/14.
//  Copyright (c) 2014 Manalo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>



@interface GFViewController : UIViewController <CLLocationManagerDelegate> {
    
    NSMutableArray *goodFoodData;
    
}

@property (nonatomic, retain) NSMutableArray *goodFoodData;
@end
