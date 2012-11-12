//
//  APDropDownView.h
//  APDropdownView
//
//  Created by Alin Petrus on 9/14/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APDropDownTableView.h"

@class APDropDownView;

@protocol APDropDownViewDelegate <NSObject>
@optional
- (void)dropDownView:(APDropDownView*)dropDownView didSelectItemAtIndexPath:(NSIndexPath*)indexPath;
@end

@protocol APDropDownViewDataSource <NSObject>
- (NSInteger)dropDownView:(APDropDownView *)dropDownView numberOfItemsInSection:(NSInteger)section;

- (UITableViewCell *)dropDownView:(APDropDownView *)dropDownView itemForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional

- (NSInteger)numberOfSectionsInDropDownView:(APDropDownView *)dropDownView;              // Default is 1 if not implemented
@end



@interface APDropDownView : UIView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id <APDropDownViewDataSource> dataSource;
@property (nonatomic, weak) id <APDropDownViewDelegate> delegate;

- (id)dequeueCellWithReuseIdentifier:(NSString*)identifier;
- (void)setBackgroundImage:(UIImage*)image forState:(UIControlState)state;
- (void)setAccessoryImage:(UIImage*)image forState:(UIControlState)state;
- (void)setDropDownTitle:(NSString*)title forState:(UIControlState)state;

@end
