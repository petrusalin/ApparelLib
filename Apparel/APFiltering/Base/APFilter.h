//
//  APFilter.h
//  APFiltering
//
//  Created by Alin Petrus on 10/29/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import <CoreImage/CoreImage.h>
#import <CoreGraphics/CoreGraphics.h>
#import "APFilterDefines.h"

@interface APFilter : NSObject {
    CIFilter    *_filter;
}

@property (nonatomic, strong) CIFilter *filter;
@property (nonatomic, readonly, strong) CIImage *outputImage;

- (CIImage*)outputImage;
- (void)setDefaultParameters;

@end
