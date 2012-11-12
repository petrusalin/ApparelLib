//
//  APNoticeContentView.m
//  APNoticeView
//
//  Created by Alin Petrus on 8/24/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APNoticeContentView.h"

static const NSUInteger kDefaultMargin  = 5;

@implementation APNoticeContentView

#pragma mark -
#pragma mark lifecycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin,
                                                                kDefaultMargin,
                                                                frame.size.width,
                                                                20.0)];
        _titleLabel.text = @"Title";
        _titleLabel.lineBreakMode = UILineBreakModeWordWrap;
        _titleLabel.numberOfLines = 0;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_titleLabel];
        
        _messageTextView = [[UITextView alloc] initWithFrame:CGRectMake(0.0,
                                                                        _titleLabel.frame.size.height + 2 * kDefaultMargin,
                                                                        frame.size.width,
                                                                        frame.size.height - CGRectGetMaxY(_titleLabel.frame))];
        _messageTextView.backgroundColor = [UIColor clearColor];
        _messageTextView.editable = NO;
        _messageTextView.scrollEnabled = YES;
        _messageTextView.textColor = [UIColor whiteColor];
        [self addSubview:_messageTextView];
        
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
#pragma mark setters & getters

- (void)setNotice:(APNotice *)notice {
    _titleLabel.text = notice.title;
    _titleLabel.textColor = notice.titleColor;
    _titleLabel.font = notice.messageFont;
    
    _messageTextView.text = notice.message;
    _messageTextView.textColor = notice.messageColor;
    _messageTextView.font = notice.messageFont;
}

@end
