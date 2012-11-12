//
//  APNoticeView.m
//  APNoticeView
//
//  Created by Alin Petrus on 8/24/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APNoticeView.h"
#import "APNoticeViewOverlayWindow.h"
#import "APNoticeViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "APNoticeContentView.h"
#import "APUtils.h"

static const NSUInteger kMinHeight = 150;
static const NSUInteger kMinWidth = 100;
static const NSUInteger kDefaultWidth = 300;
static const NSUInteger kDefaultHeight = 140;
static const NSUInteger kDefaultButtonSize = 40;
static const NSUInteger kDefaultMargin = 5;
static const CGFloat    kDeltaOffset = 10;

@interface APNoticeView ()
/**
 Private method to get the button coresponding to the button type
 @param type - the type of the button
 @return the button for that type
 */
- (UIButton*)buttonForType:(APButtonType)type;
/**
 Private method to validate a given frame for the notice view
 @param frame - the frame that was passed in the iniliazer
 @return a valid frame respecting minimum size requirements
 */
- (CGRect)validatedFrame:(CGRect)frame;
/**
 Private method that creates the first 3 (or less) content views
 */
- (void)loadNoticeContentViews;
/**
 Private method that gets called when the page control is clicked
 */
- (void)changePage;
/**
 Private method that gets called when the user wants to dismiss the notice view
 */
- (void)close;
/**
 Private method that gets called when the right button is pressed
 */
- (void)nextPressed;
/**
 Private method that triggers the automatic scroll to the next page
 */
- (void)nextNotice;
/**
 Private method that gets called when the left button pressed.
 */
- (void)previousPressed;
/**
 Private method that triggers the automatic scroll to the previous page
 */
- (void)previousNotice;
/**
 Private method that gets called after a change of pages to check if recycling is required
 */
- (void)prepareNotices;
@end

static const APNoticeViewOverlayWindow   *_overlay = nil;

@implementation APNoticeView

@synthesize delegate = _delegate;

#pragma mark -
#pragma mark lifecycle

- (id)initWithFrame:(CGRect)frame {
    return [self initWithFrame:CGRectMake(0, 0, kDefaultWidth, kDefaultHeight) andNoticesArray:[NSArray array]];
}

- (id)initWithNoticesArray:(NSArray*)array {
    return [self initWithFrame:CGRectMake(0, 0, kDefaultWidth, kDefaultHeight) andNoticesArray:array];
}

- (id)initWithFrame:(CGRect)frame andNoticesArray:(NSArray*)array {
    frame = [self validatedFrame:frame];
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        _subviewsLayedOut = NO;
        _shouldUpdatePageIndicator = YES;
        _currentPage = 0;
        
        _noticeArray = [[NSArray alloc] initWithArray:array];
        //only 3 content views will be used and recycled
        _contentViewsArray = [[NSMutableArray alloc] initWithCapacity:3];
        
        //create the UI components with default images
        [self setBackgroundImage:[UIImage imageWithContentsOfFile:APBUNDLE(@"APAssets.bundle/Images/noticeViewBackground.png")]];
        
        _closeButton = [[UIButton alloc] init];
        [_closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [_closeButton setImage:[UIImage imageWithContentsOfFile:APBUNDLE(@"APAssets.bundle/Images/close.png")] forState:UIControlStateNormal];
        [_closeButton setImage:[UIImage imageWithContentsOfFile:APBUNDLE(@"APAssets.bundle/Images/closeSelected.png")] forState:UIControlStateHighlighted];
        [self addSubview:_closeButton];
        
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.numberOfPages = _noticeArray.count;
        [_pageControl addTarget:self action:@selector(changePage) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_pageControl];
        
        _leftButton = [[UIButton alloc] init];
        [_leftButton addTarget:self action:@selector(previousPressed) forControlEvents:UIControlEventTouchUpInside];
        [_leftButton setImage:[UIImage imageWithContentsOfFile:APBUNDLE(@"APAssets.bundle/Images/left.png")] forState:UIControlStateNormal];
        [_leftButton setImage:[UIImage imageWithContentsOfFile:APBUNDLE(@"APAssets.bundle/Images/leftSelected.png")] forState:UIControlStateHighlighted];
        [self addSubview:_leftButton];
        
        _rightButton = [[UIButton alloc] init];
        [_rightButton addTarget:self action:@selector(nextPressed) forControlEvents:UIControlEventTouchUpInside];
        [_rightButton setImage:[UIImage imageWithContentsOfFile:APBUNDLE(@"APAssets.bundle/Images/right.png")] forState:UIControlStateNormal];
        [_rightButton setImage:[UIImage imageWithContentsOfFile:APBUNDLE(@"APAssets.bundle/Images/rightSelected.png")] forState:UIControlStateHighlighted];
        [self addSubview:_rightButton];
        
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.userInteractionEnabled = YES;
        [self addSubview:_scrollView];
    }
    
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //draw the background image over the whole frame
    [_backgroundImage drawInRect:rect];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //initialize the frames only at layout subviews. This is called after the APNoticeViewController has loaded
    CGRect frame = self.frame;
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
    
    UIImage *image = [UIImage imageWithContentsOfFile:APBUNDLE(@"APAssets.bundle/Images/close.png")];
    CGSize buttonSize = CGSizeMake(kDefaultButtonSize, kDefaultButtonSize);
    
    if (image.size.width < kDefaultButtonSize) {
        buttonSize.width = image.size.width;
    }
    if (image.size.height < kDefaultButtonSize) {
        buttonSize.height = image.size.height;
    }
    
    _closeButton.frame = CGRectMake(frame.size.width - buttonSize.width,
                                    0,
                                    buttonSize.width,
                                    buttonSize.height);
    
    _pageControl.frame = CGRectMake(buttonSize.width + 2 * kDefaultMargin,
                                    frame.size.height - kDefaultMargin - buttonSize.height,
                                    frame.size.width - 4 * kDefaultMargin - 2 * buttonSize.width,
                                    buttonSize.height);
    _leftButton.frame = CGRectMake(kDefaultMargin,
                                   frame.size.height - kDefaultMargin - buttonSize.height,
                                   buttonSize.width,
                                   buttonSize.height);
    _rightButton.frame = CGRectMake(frame.size.width - kDefaultMargin - buttonSize.width,
                                    frame.size.height - kDefaultMargin - buttonSize.height,
                                    buttonSize.width,
                                    buttonSize.height);
    _scrollView.frame = CGRectMake(kDefaultMargin,
                                   _closeButton.frame.origin.y + _closeButton.frame.size.height,
                                   frame.size.width - 2 * kDefaultMargin,
                                   frame.size.height - _closeButton.frame.origin.y - _closeButton.frame.size.height - _pageControl.frame.size.height - kDefaultMargin);
    //set the width of the content size to a multiple of the number of notices
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * _noticeArray.count, _scrollView.frame.size.height);
    
    //only load the content views once
    if (!_subviewsLayedOut) {
        _subviewsLayedOut = YES;
        [self loadNoticeContentViews];
    }
}


#pragma mark -
#pragma mark setters & getters

- (void)setBackgroundImage:(UIImage*)image {
    _backgroundImage = image;
    
    [self setNeedsDisplay];
}

- (void)setImage:(UIImage*)image forState:(UIControlState)state forButtonType:(APButtonType)type {
    UIButton *button = [self buttonForType:type];
    
    [button setImage:image forState:state];
}

#pragma mark -
#pragma mark public

- (void)show {
    if (_delegate && [_delegate respondsToSelector:@selector(willPresentNoticeView:)]) {
        [_delegate willPresentNoticeView:self];
    }
    
    [[NSRunLoop currentRunLoop] runMode: NSDefaultRunLoopMode beforeDate:[NSDate date]];
	
	APNoticeViewController* nvc = [[APNoticeViewController alloc] init];
	nvc.view.backgroundColor = [UIColor clearColor];

	_overlay = [[APNoticeViewOverlayWindow alloc] initWithFrame: [UIScreen mainScreen].bounds];
	_overlay.alpha = 0.0;
	_overlay.backgroundColor = [UIColor clearColor];
	_overlay.rootViewController = nvc;
	[_overlay makeKeyAndVisible];
	
	// fade in the window
	[UIView animateWithDuration:0.2 animations: ^{
		_overlay.alpha = 1;
	}];
	
	[nvc.view addSubview: self];

    //center the view in the view controller
	self.center = CGPointMake( CGRectGetMidX( nvc.view.bounds ), self.frame.origin.y + self.frame.size.height / 2 + kDefaultMargin );
	self.frame = CGRectIntegral( self.frame );
}

#pragma mark -
#pragma mark private

- (UIButton*)buttonForType:(APButtonType)type {
    switch (type) {
        case APButtonClose:
            return _closeButton;
        case APButtonLeft:
            return _leftButton;
        case APButtonRight:
            return _rightButton;
        default:
            return nil;
    }
}

- (CGRect)validatedFrame:(CGRect)frame {
    //validate the frame that was passed, check if respects the minimum frame requirements
    if (frame.size.width < kDefaultWidth ) {
        frame.size.width = kDefaultWidth;
    }
    
    if (frame.size.height < kDefaultHeight) {
        frame.size.height = kDefaultHeight;
    }
    
    return frame;
}

- (void)loadNoticeContentViews {
    //create the visible notice content view
    CGRect frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    frame.size = _scrollView.frame.size;
    
    APNoticeContentView *noticeVisible = [[APNoticeContentView alloc] initWithFrame:frame];
    if (_noticeArray.count > 0) {
        APNotice *notice = [_noticeArray objectAtIndex:0];
        [noticeVisible setNotice:notice];
    }
    
    [_scrollView addSubview:noticeVisible];
    [_contentViewsArray addObject:noticeVisible];
    
    //create the right notice content view
    frame.origin.x = _scrollView.frame.size.width;
    frame.origin.y = 0;
    frame.size = _scrollView.frame.size;
    
    APNoticeContentView *noticeRight = [[APNoticeContentView alloc] initWithFrame:frame];
    if (_noticeArray.count > 1) {
        APNotice *notice = [_noticeArray objectAtIndex:1];
        [noticeRight setNotice:notice];
    }
    
    [_scrollView addSubview:noticeRight];
    [_contentViewsArray addObject:noticeRight];
    
    //create the last notice content view
    frame.origin.x = _scrollView.frame.size.width * 2;
    frame.origin.y = 0;
    frame.size = _scrollView.frame.size;
    
    APNoticeContentView *noticeExtremeRight = [[APNoticeContentView alloc] initWithFrame:frame];
    if (_noticeArray.count > 2) {
        APNotice *notice = [_noticeArray objectAtIndex:2];
        [noticeExtremeRight setNotice:notice];
    }
    [_scrollView addSubview:noticeExtremeRight];
    [_contentViewsArray addObject:noticeExtremeRight];
}

- (void)prepareNotices {
    //only try recycling the 3 existing content views if there are more than 3 notices 
    if (_noticeArray.count > 3) {
        CGFloat maxX = 0;
        CGFloat minX = _scrollView.frame.size.width * _noticeArray.count;
        APNoticeContentView *minNoticeView = nil;
        APNoticeContentView *maxNoticeView = nil;
        
        //get the left and right content views
        for (APNoticeContentView *noticeView in _contentViewsArray) {
            if (noticeView.frame.origin.x > maxX) {
                maxX = noticeView.frame.origin.x;
                maxNoticeView = noticeView;
            }
            
            if (noticeView.frame.origin.x < minX) {
                minX = noticeView.frame.origin.x;
                minNoticeView = noticeView;
            }
        }
        
        //check if a content view needs to be recycled to set up the right notice view
        if (maxX <= _scrollView.contentOffset.x + kDeltaOffset && _currentPage < _noticeArray.count - 1) {
            APNotice *notice = [_noticeArray objectAtIndex:_currentPage + 1];
            [minNoticeView setNotice:notice];
            minNoticeView.frame = CGRectMake((_currentPage + 1) * _scrollView.frame.size.width,
                                             minNoticeView.frame.origin.y,
                                             _scrollView.frame.size.width,
                                             _scrollView.frame.size.width);
            [self setNeedsDisplay];
            //do not trigger the min update
            return;
        }
        
        //check if a content view needs to be recycled to set up the left notice view
        if (minX > _scrollView.contentOffset.x - kDeltaOffset && _currentPage != 0) {
            APNotice *notice = [_noticeArray objectAtIndex:_currentPage - 1];
            [maxNoticeView setNotice:notice];
            maxNoticeView.frame = CGRectMake((_currentPage - 1) * _scrollView.frame.size.width,
                                             maxNoticeView.frame.origin.y,
                                             _scrollView.frame.size.width,
                                             _scrollView.frame.size.width);
            [self setNeedsDisplay];
        }
    }
}

#pragma mark -
#pragma mark actions

- (void)close {
    if (_delegate && [_delegate respondsToSelector:@selector(willDismissNoticeView:)]) {
        [_delegate willDismissNoticeView:self];
    }
    
    self.window.backgroundColor = [UIColor clearColor];
    self.window.alpha = 1;
    
    [UIView animateWithDuration: 0.2
                     animations: ^{
                         [self.window resignKeyWindow];
                         self.window.alpha = 0;
                     }
                     completion: ^(BOOL finished) {
                         if (_delegate && [_delegate respondsToSelector:@selector(didDismissNoticeView:)]) {
                             [_delegate didDismissNoticeView:self];
                         }
                     }];
}

- (void)previousPressed {
    _shouldUpdatePageIndicator = YES;
    [self previousNotice];
}

- (void)nextPressed {
    _shouldUpdatePageIndicator = YES;
    [self nextNotice];
}

- (void)nextNotice {
    if (_currentPage == _noticeArray.count) {
        return;
    }
    
    [_scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width * (_currentPage + 1),
                                                0,
                                                _scrollView.frame.size.width,
                                                _scrollView.frame.size.height) animated:YES];
}

- (void)previousNotice {
    if (_currentPage == 0) {
        return;
    }
    
    [_scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width * (_currentPage - 1),
                                                0,
                                                _scrollView.frame.size.width,
                                                _scrollView.frame.size.height) animated:YES];
}

- (void)changePage {
    if (_currentPage < _pageControl.currentPage) {
        _shouldUpdatePageIndicator = NO;
        [self nextNotice];
    } else if (_currentPage > _pageControl.currentPage) {
        _shouldUpdatePageIndicator = NO;
        [self previousNotice];
    }
}

#pragma mark -
#pragma mark scrollview delegate methods

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = _scrollView.frame.size.width;
    int page = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    if (_shouldUpdatePageIndicator) {
        _pageControl.currentPage = page;
    }
    
    [self prepareNotices];
    _currentPage = page;
}

- (void)scrollViewWillBeginDragging {
    _shouldUpdatePageIndicator = YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _shouldUpdatePageIndicator = YES;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    _shouldUpdatePageIndicator = YES;
}

@end
