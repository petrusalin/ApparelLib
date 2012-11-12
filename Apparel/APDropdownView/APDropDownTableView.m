//
//  APDrownDownTableView.m
//  APDropdownView
//
//  Created by Alin Petrus on 9/14/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APDropDownTableView.h"
#import "APNoticeViewController.h"
#import "APNoticeViewOverlayWindow.h"
#import <QuartzCore/QuartzCore.h>

@interface APDropDownTableView ()
@property (nonatomic, assign) CGRect tableViewRect;
@property (nonatomic, retain) APNoticeViewController* nvc;
@end

@implementation APDropDownTableView

@synthesize tableViewRect = _tableViewRect;
@synthesize nvc = _nvc;

static const NSUInteger kDefaultMargin = 5;
static const NSUInteger kDefaultDropDownHeight = 200;
static const APNoticeViewOverlayWindow   *_overlay = nil;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _tableViewRect = frame;
        _tableView = [[UITableView alloc] initWithFrame:self.frame];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _tableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _tableView.layer.borderWidth = 2;
        _tableView.layer.cornerRadius = 5;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOpacity = 1.0;
        self.layer.shadowOffset = CGSizeMake(-2, 4);
        self.layer.shouldRasterize = YES;
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

- (void)show {
    [[NSRunLoop currentRunLoop] runMode: NSDefaultRunLoopMode beforeDate:[NSDate date]];
    
    [self addSubview:_tableView];
	
	_nvc = [[APNoticeViewController alloc] init];
	_nvc.view.backgroundColor = [UIColor clearColor];
    
	_overlay = [[APNoticeViewOverlayWindow alloc] initWithFrame: [UIScreen mainScreen].bounds];
	_overlay.alpha = 0.0;
    _overlay.backgroundColor = [UIColor clearColor];
	_overlay.rootViewController = _nvc;
	[_overlay makeKeyAndVisible];
	
	// fade in the window
	[UIView animateWithDuration:0.2 animations: ^{
		_overlay.alpha = 1;
	}];
	
	[_nvc.view addSubview: self];
    
    self.frame = _overlay.frame;
    [UIView animateWithDuration:0.3 animations:^{
        _tableView.frame = CGRectMake(_tableViewRect.origin.x - 2,
                                      _tableViewRect.origin.y - 3,
                                      _tableViewRect.size.width + 4,
                                      kDefaultDropDownHeight);
    }];
}

- (void)hide {
    APDropDownTableView * __weak tbv = self;
    [UIView animateWithDuration:0.3 animations:^{
        _tableView.frame = CGRectMake(_tableView.frame.origin.x,
                                      _tableView.frame.origin.y,
                                      _tableView.frame.size.width,
                                      0);
    }completion:^(BOOL completion){
        _overlay.rootViewController = nil;
         [tbv removeFromSuperview];
        _nvc = nil;
        [_overlay resignKeyWindow];
        _overlay.alpha = 0;
    }];
}


@end
