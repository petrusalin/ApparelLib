//
//  APContextualButton.h
//  ApparelLibDemo
//
//  Created by Alin Petrus on 11/12/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DEFAULT_BUTTON_SIZE (48)

@interface APContextualButton : UIButton

@property (nonatomic, assign) NSInteger positionIndex;
@property (nonatomic, strong) UIImage *maskImage;

- (id)initWithMaskImage:(UIImage*)image;
- (void)setButtonImage:(UIImage*)image forState:(UIControlState)state useMask:(BOOL)useMask;

@end
