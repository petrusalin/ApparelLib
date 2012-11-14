//
//  APViewController.h
//  ApparelLibDemo
//
//  Created by Alin Petrus on 10/8/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APDropDownView.h"
#import "APContextualMenuViewController.h"

@interface APViewController : APContextualMenuViewController <APDropDownViewDataSource, APDropDownViewDelegate>

- (IBAction)showNoticeViewDemo:(id)sender;
@end
