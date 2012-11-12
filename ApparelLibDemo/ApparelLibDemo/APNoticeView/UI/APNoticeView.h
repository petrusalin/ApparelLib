//
//  APNoticeView.h
//  APNoticeView
//
//  Created by Alin Petrus on 8/24/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APNotice.h"
#import "APNoticeViewOverlayWindow.h"

typedef enum APButtonType {
    APButtonLeft = 0,
    APButtonRight,
    APButtonClose
}APButtonType;

@class APNoticeView;

@protocol APNoticeViewDelegate <NSObject>
- (void)willPresentNoticeView:(APNoticeView *)noticeView;  // before animation and showing view
- (void)didPresentNoticeView:(APNoticeView *)noticeView;  // after animation

- (void)willDismissNoticeView:(APNoticeView *)noticeView; // before animation and hidding view
- (void)didDismissNoticeView:(APNoticeView *)noticeView;  //after animation and hidding view
@end

/**
 @brief This class is similiar in functionalities to the UIAlertView. It has it's own window, and shows notices 
        with message and title in a paginated UIScrollView. The actual notices are objects of type APNoticeContentView
 */
@interface APNoticeView : UIView <UIScrollViewDelegate> {
    UIImage                     *_backgroundImage;///<image that is drawn as the background for the notice view
    UIScrollView                *_scrollView;///<scroll view that is used to display notices in APNoticeContentViews, paged
    UIPageControl               *_pageControl;///<control which displays the page the user is currently seeing
    UIButton                    *_leftButton;///<button that permits navigating to the left page from the current one
    UIButton                    *_rightButton;///<button that permits navigating to the right page from the current one
    UIButton                    *_closeButton;///<button which dismisses the APNoticeView
    
    NSArray                     *_noticeArray;///<array which holds all of the notices that are to be displayed to the user
    NSMutableArray              *_contentViewsArray;///<array with 3 content views. These are reused to display the notice info
    BOOL                        _subviewsLayedOut;///<a bool to check if layout has occured
    BOOL                        _shouldUpdatePageIndicator;///<a bool to check if it's required to update the indicator (not needed when switching the page by clicking the indicator)
    NSUInteger                  _currentPage;///<index of the page currently being displayed
}

@property (nonatomic, weak) id<APNoticeViewDelegate> delegate;

/**
 Designated initializer
 @param frame - frame for the notice view
 @param array - an array of APNotice objects
 @return an instance of APNoticeView
 */
- (id)initWithFrame:(CGRect)frame andNoticesArray:(NSArray*)array;
/**
 Convenience initializer
 @param array - an array of APNotice objects
 @return an instance of APNoticeView
 */
- (id)initWithNoticesArray:(NSArray*)array;
/**
 Method that sets background image for the notice view
 @param backgroundImage - sets the image and draws the background
 */
- (void)setBackgroundImage:(UIImage*)image;
/**
 Method that can be used to set images for different states for the close/left/right buttons
 @param image - image to be used
 @param state - the state of the button for which the image should be used
 @param type - the button type for which the image should be used
 */
- (void)setImage:(UIImage*)image forState:(UIControlState)state forButtonType:(APButtonType)type;
/**
 Method that should be called after initializing and customizing the notice to display it to the user
 */
- (void)show;

@end
