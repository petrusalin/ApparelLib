//
//  APNoticeViewOverlayWindow.h
//  APNoticeView
//
//  Created by Alin Petrus on 8/24/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 @brief This is the overlay window used to present the APNoticeView.
        It handles saving and restoring the previous key window when 
        the APNoticeView is dismissed
 */
@interface APNoticeViewOverlayWindow : UIWindow

@property (nonatomic, strong) UIWindow* oldKeyWindow;///<property that holds the window that was key before the noticeView was presented

@end
