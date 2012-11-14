//
//  APContextualView.h
//  ApparelLibDemo
//
//  Created by Alin Petrus on 11/12/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol APContextualViewDelegate;
@protocol APContextualViewDataSource;

@interface APContextualView : UIView {
    id<APContextualViewDelegate>        __weak _delegate;
    id<APContextualViewDataSource>      __weak _dataSource;
}

@property(nonatomic, weak) id<APContextualViewDelegate> delegate;
@property(nonatomic, weak) id<APContextualViewDataSource> dataSource;

- (void)showWithCenter:(CGPoint)center;

@end


@protocol APContextualViewDelegate <NSObject>

@optional
- (UIImage*)imageForButtonWithIndex:(NSUInteger)index andState:(UIControlState)state;
- (UIImage*)imageForCloseButtonState:(UIControlState)state;
- (UIImage*)maskImageForButtons;
- (void)tappedButtonAtIndex:(NSUInteger)index;
- (BOOL)shouldUseMask;
- (void)menuWillAppear;
- (void)menuDidAppear;
- (void)menuWillDisappear;
- (void)menuDidDisappear;
@end

@protocol APContextualViewDataSource <NSObject>

@required
- (NSUInteger)numberOfButtons;

@end
