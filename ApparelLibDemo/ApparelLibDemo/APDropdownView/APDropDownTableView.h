//
//  APDrownDownTableView.h
//  APDropdownView
//
//  Created by Alin Petrus on 9/14/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APDropDownTableView : UIView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView *tableView;

- (void)show;
- (void)hide;

@end
