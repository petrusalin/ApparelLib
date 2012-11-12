//
//  APNoticeContentView.h
//  APNoticeView
//
//  Created by Alin Petrus on 8/24/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APNotice.h"

/**
 @brief This class represents a display view for a APNotice object. This is used together with a APNoticeView
        where it acts as a page inside a paginated scrollView
 */
@interface APNoticeContentView : UIView {
    UILabel     *_titleLabel;///<label which will be used to diplay the notice title
    UITextView  *_messageTextView;///<textView which will be used to display the notice message;
}

/**
 Method used to set the notice
 */
- (void)setNotice:(APNotice*)notice;


@end
