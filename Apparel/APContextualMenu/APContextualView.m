//
//  APContextualView.m
//  ApparelLibDemo
//
//  Created by Alin Petrus on 11/12/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APContextualView.h"
#import "APContextualButton.h"
#import "APNoticeViewOverlayWindow.h"
#import "APNoticeViewController.h"

#define MAX_NR_OF_BUTTONS (8)
#define DEFAULT_RADIUS (DEFAULT_BUTTON_SIZE * 1.5)
#define DEFAULT_ANIMATION_DURATION (0.6)

static const APNoticeViewOverlayWindow   *_overlay = nil;

@interface APContextualView ()
@property (nonatomic, strong) UIImage *maskImage;
@property (nonatomic, assign) BOOL shouldUseMask;
@property (nonatomic, assign) NSUInteger numberOfButtons;
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, assign) CGPoint menuCenter;
@property (nonatomic, strong) APContextualButton *closeButton;
@property (nonatomic, assign) BOOL isOnScreen;

- (void)initializeButtons;
- (void)buttonClicked:(id)sender;
- (void)closeMenu:(id)sender;
- (CGPoint)validMenuCenterFromPoint:(CGPoint)center;
@end

@implementation APContextualView

#pragma mark -
#pragma mark lifecycle

@synthesize delegate = _delegate;
@synthesize dataSource = _dataSource;

- (id)init
{
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.buttons = [[NSMutableArray alloc] init];
        _shouldUseMask = NO;
        self.menuCenter = CGPointZero;
        self.closeButton = [[APContextualButton alloc] init];
        [self.closeButton addTarget:self action:@selector(closeMenu:) forControlEvents:UIControlEventTouchUpInside];
        self.isOnScreen = NO;
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark -
#pragma mark public

- (void)showWithCenter:(CGPoint)center {
    if(self.isOnScreen) {
        return;
    }
    
    self.isOnScreen = YES;
    self.menuCenter = center;
    
    if (_delegate && [_delegate respondsToSelector:@selector(menuWillAppear)]) {
        [_delegate menuWillAppear];
    }
    
    CGPoint validCenter = [self validMenuCenterFromPoint:center];   
    
    self.closeButton.frame = CGRectMake(validCenter.x - DEFAULT_BUTTON_SIZE / 2,
                                        validCenter.y - DEFAULT_BUTTON_SIZE / 2,
                                        DEFAULT_BUTTON_SIZE,
                                        DEFAULT_BUTTON_SIZE);
    
    for (APContextualButton *button in self.buttons) {
        button.frame = self.closeButton.frame;
        [self addSubview:button];
    }
    
    self.closeButton.alpha = 0.0;
    [self addSubview:self.closeButton];
    
    [[NSRunLoop currentRunLoop] runMode: NSDefaultRunLoopMode beforeDate:[NSDate date]];
	
	APNoticeViewController* nvc = [[APNoticeViewController alloc] init];
	nvc.view.backgroundColor = [UIColor clearColor];
    
	_overlay = [[APNoticeViewOverlayWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	_overlay.backgroundColor = [UIColor clearColor];
	_overlay.rootViewController = nvc;
	[_overlay makeKeyAndVisible];
	
	[nvc.view addSubview:self];
    
    //center the view in the view controller
	self.center = CGPointMake( CGRectGetMidX( nvc.view.bounds ), self.frame.origin.y + self.frame.size.height / 2);
	self.frame = CGRectIntegral( self.frame );
    
    [UIView animateWithDuration:DEFAULT_ANIMATION_DURATION animations:^ {
        self.closeButton.alpha = 1.0;
    }];
    
    for (APContextualButton *button in self.buttons) {
        [UIView animateWithDuration:DEFAULT_ANIMATION_DURATION
                         animations:^ {
                             button.frame = CGRectMake(validCenter.x + cos(button.positionIndex * M_PI_4) * DEFAULT_RADIUS - DEFAULT_BUTTON_SIZE / 2,
                                                       validCenter.y + sin(button.positionIndex * M_PI_4) * DEFAULT_RADIUS - DEFAULT_BUTTON_SIZE / 2,
                                                       DEFAULT_BUTTON_SIZE,
                                                       DEFAULT_BUTTON_SIZE);
                         }
                         completion:^(BOOL complete) {
                             if (button.positionIndex == [self.buttons count] - 1) {
                                 if (_delegate && [_delegate respondsToSelector:@selector(menuDidAppear)]) {
                                     [_delegate menuDidAppear];
                                 }
                             }
                         }];
    }
}

#pragma mark -
#pragma mark setters and getters

- (void)setDelegate:(id<APContextualViewDelegate>)delegate {
    _delegate = delegate;
    
    if ([_delegate respondsToSelector:@selector(shouldUseMask)]) {
        self.shouldUseMask = [_delegate shouldUseMask];
    }
    
    if (self.shouldUseMask) {
        self.maskImage = [_delegate maskImageForButtons];
        self.closeButton.maskImage = self.maskImage;
    }
    
    if (self.numberOfButtons > 0 && _dataSource && _delegate) {
        [self initializeButtons];
    }
}

- (void)setDataSource:(id<APContextualViewDataSource>)dataSource {
    _dataSource = dataSource;
    
    if ([_dataSource respondsToSelector:@selector(numberOfButtons)]) {
        self.numberOfButtons = [_dataSource numberOfButtons];
        if (self.numberOfButtons > MAX_NR_OF_BUTTONS) {
            self.numberOfButtons = MAX_NR_OF_BUTTONS;
        }
        
        if (_delegate && _dataSource) {
            [self initializeButtons];
        }
    }
}

#pragma mark -
#pragma mark private

- (void)initializeButtons {
    [_buttons removeAllObjects];
    
    UIImage *closeImage = [_delegate imageForCloseButtonState:UIControlStateNormal];
    UIImage *closeImageSelected = [_delegate imageForCloseButtonState:UIControlStateSelected];
    
    [self.closeButton setButtonImage:closeImage forState:UIControlStateNormal useMask:self.shouldUseMask];
    [self.closeButton setButtonImage:closeImageSelected forState:UIControlStateSelected useMask:self.shouldUseMask];
    
    for (NSUInteger i = 0; i < self.numberOfButtons; i++) {
        APContextualButton *button = [[APContextualButton alloc] initWithMaskImage:self.maskImage];
        button.positionIndex = i;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttons addObject:button];
        
        UIImage *normalImage = [_delegate imageForButtonWithIndex:i andState:UIControlStateNormal];
        UIImage *selectedImage = [_delegate imageForButtonWithIndex:i andState:UIControlStateSelected];
            
        [button setButtonImage:normalImage forState:UIControlStateNormal useMask:self.shouldUseMask];
        [button setButtonImage:selectedImage forState:UIControlStateSelected useMask:self.shouldUseMask];
    }
}

- (void)buttonClicked:(id)sender {
    APContextualButton *button = (APContextualButton*)sender;
    NSUInteger buttonIndex = button.positionIndex;
    
    if (_delegate && [_delegate respondsToSelector:@selector(tappedButtonAtIndex:)]) {
        [_delegate tappedButtonAtIndex:buttonIndex];
    }
    
    [self closeMenu:nil];
}

- (void)closeMenu:(id)sender {
    if (!self.isOnScreen) {
        return;
    }

    self.isOnScreen = NO;
    
    if (_delegate && [_delegate respondsToSelector:@selector(menuWillDisappear)]) {
        [_delegate menuWillDisappear];
    }
    
    [UIView animateWithDuration:DEFAULT_ANIMATION_DURATION animations:^ {
        self.closeButton.alpha = 0.0;
    }];
    
    for (APContextualButton *button in self.buttons) {
        [UIView animateWithDuration:DEFAULT_ANIMATION_DURATION
                         animations:^ {
                             button.frame = CGRectMake(self.closeButton.frame.origin.x,
                                                       self.closeButton.frame.origin.y,
                                                       DEFAULT_BUTTON_SIZE,
                                                       DEFAULT_BUTTON_SIZE);
                         }
                         completion:^(BOOL complete) {
                             [button removeFromSuperview];
                             if (button.positionIndex == [self.buttons count] - 1) {
                                 [self.closeButton removeFromSuperview];
                                 [self.window resignKeyWindow];
                                 self.window.alpha = 0;
                                 
                                 if (_delegate && [_delegate respondsToSelector:@selector(menuDidDisappear)]) {
                                     [_delegate menuDidDisappear];
                                 }
                             }
                         }];
    }
    
}

- (CGPoint)validMenuCenterFromPoint:(CGPoint)center {
    //could only substract DEFAULT_BUTTON_SIZE / 2, but it would be better to have some margins
    if (center.x - DEFAULT_RADIUS - DEFAULT_BUTTON_SIZE < 0) {
        center.x = DEFAULT_RADIUS + DEFAULT_BUTTON_SIZE;
    } else if (center.x + DEFAULT_RADIUS + DEFAULT_BUTTON_SIZE > self.frame.origin.x + self.frame.size.width) {
        center.x = self.frame.origin.x + self.frame.size.width - DEFAULT_RADIUS - DEFAULT_BUTTON_SIZE;
    }
    
    if (center.y - DEFAULT_RADIUS - DEFAULT_BUTTON_SIZE < 0) {
        center.y = DEFAULT_BUTTON_SIZE + DEFAULT_RADIUS;
    } else if (center.y + DEFAULT_RADIUS + DEFAULT_BUTTON_SIZE > self.frame.origin.y + self.frame.size.height) {
        center.y = self.frame.origin.y + self.frame.size.height - DEFAULT_RADIUS - DEFAULT_BUTTON_SIZE;
    }
    
    return center;
}

@end
