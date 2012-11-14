//
//  APContextualMenuViewController.h
//  ApparelLibDemo
//
//  Created by Alin Petrus on 11/12/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APContextualView.h"

@interface APContextualMenuViewController : UIViewController <APContextualViewDataSource, APContextualViewDelegate>

@property (nonatomic, strong) APContextualView *contextualMenu;

@end
