//
//  APContextualButton.m
//  ApparelLibDemo
//
//  Created by Alin Petrus on 11/12/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APContextualButton.h"

@interface APContextualButton ()
- (UIImage *) maskImage:(UIImage *)image withMask:(UIImage *)maskImage;
@end

@implementation APContextualButton

@synthesize maskImage = _maskImage;
@synthesize positionIndex = _positionIndex;

#pragma mark -
#pragma mark lifecycle

- (id)initWithMaskImage:(UIImage *)image {
    self = [super init];
    
    if (self) {
        self.maskImage = image;
        self.frame = CGRectMake(0, 0, DEFAULT_BUTTON_SIZE, DEFAULT_BUTTON_SIZE);
        self.contentMode = UIViewContentModeScaleAspectFit;
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

- (void)setButtonImage:(UIImage*)image forState:(UIControlState)state useMask:(BOOL)useMask {
    if (useMask) {
        UIImage *newImage = [self maskImage:image withMask:self.maskImage];
        [self setImage:newImage forState:state];
    } else {
        [self setImage:image forState:state];
    }
}

#pragma mark -
#pragma mark private

- (UIImage *)maskImage:(UIImage *)image withMask:(UIImage *)maskImage {
    CGImageRef maskRef = maskImage.CGImage;
    
    CGImageRef theMask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                           CGImageGetHeight(maskRef),
                                           CGImageGetBitsPerComponent(maskRef),
                                           CGImageGetBitsPerPixel(maskRef),
                                           CGImageGetBytesPerRow(maskRef),
                                           CGImageGetDataProvider(maskRef), NULL, false);
    
    CGImageRef maskedImage = CGImageCreateWithMask([image CGImage], theMask);
    
    UIImage *returnImage = [UIImage imageWithCGImage:maskedImage];
    
    CGImageRelease(theMask);
    CGImageRelease(maskedImage);
    
    return returnImage;
}

@end
