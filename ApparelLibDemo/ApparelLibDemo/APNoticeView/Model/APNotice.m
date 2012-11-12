//
//  APNotice.m
//  APNoticeView
//
//  Created by Alin Petrus on 8/24/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APNotice.h"

@implementation APNotice

@synthesize title = _title;
@synthesize titleColor = _titleColor;
@synthesize titleFont = _titleFont;
@synthesize message = _message;
@synthesize messageColor = _messageColor;
@synthesize messageFont = _messageFont;

#pragma mark -
#pragma mark lifecycle

- (id)init {
    return [self initWithTitle:@"" andMessage:@""];
}

- (id)initWithTitle:(NSString *)title {
    return [self initWithTitle:title andMessage:@""];
}

- (id)initWithMesssage:(NSString*)message {
    return [self initWithTitle:@"" andMessage:message];
}

- (id)initWithTitle:(NSString*)title andMessage:(NSString*)message {
    self = [super init];
    
    if (self) {
        _title = title;
        _titleColor = [UIColor whiteColor];
        _titleFont = [UIFont systemFontOfSize:14];
        
        _message = message;
        _messageColor = [UIColor whiteColor];
        _messageFont = [UIFont systemFontOfSize:14];
    }
    
    return self;
}

@end
