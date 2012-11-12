//
//  APNoticeViewOverlayWindow.m
//  APNoticeView
//
//  Created by Alin Petrus on 8/24/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APNoticeViewOverlayWindow.h"

@implementation APNoticeViewOverlayWindow

- (void) makeKeyAndVisible
{
    //save the previous key window before making this one key
	self.oldKeyWindow = [[UIApplication sharedApplication] keyWindow];
	self.windowLevel = UIWindowLevelAlert;
    
	[super makeKeyAndVisible];
}

- (void) resignKeyWindow
{
	[super resignKeyWindow];
    //restore previous key window
	[self.oldKeyWindow makeKeyAndVisible];
}

@end
