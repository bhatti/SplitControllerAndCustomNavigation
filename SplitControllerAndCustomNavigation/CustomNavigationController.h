//
//  CustomNavigationController.h
//  OptionsHouse
//
//  Created by Shahzad Bhatti on 3/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomNavigationController : UITableViewController<UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray *controllers;
}

@property(nonatomic, retain) NSMutableArray *controllers;

@end
