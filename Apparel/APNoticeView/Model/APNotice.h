//
//  APNotice.h
//  APNoticeView
//
//  Created by Alin Petrus on 8/24/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 @brief This class contains information that will be displayed in a NoticeView (title and message)
 */
@interface APNotice : NSObject {
    NSString    *_title;///<NSString that holds the title of the notice
    UIColor     *_titleColor;///<Color to be used when displaying the title
    UIFont      *_titleFont;///<Font to be used when displaying the title
    
    NSString    *_message;///<NSString that holds the message of the notice
    UIColor     *_messageColor;///<Color to be used when displaying the message
    UIFont      *_messageFont;///<Font to be used when displaying the message
}

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) UIColor *messageColor;
@property (nonatomic, strong) UIFont *messageFont;

/**
 Designated initializer.
 @param title - the title for the notice
 @param message - the message for the notice
 */
- (id)initWithTitle:(NSString*)title andMessage:(NSString*)message;
/**
 Convenience initializer
 @param title - the title of the notice
 @return an instance of APNotice
 */
- (id)initWithTitle:(NSString *)title;
/**
 Convenience initializer
 @param message - the message of the notice
 @return an instance of APNotice
 */
- (id)initWithMesssage:(NSString*)message;

@end
