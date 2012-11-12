//
//  APColorInvertFilter.m
//  APFiltering
//
//  Created by Alin Petrus on 10/29/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APColorInvertFilter.h"

@implementation APColorInvertFilter

@synthesize inputImage = _inputImage;

#pragma mark -
#pragma mark life cycle

- (id)init {
    self = [super init];
    
    if (self) {
        _filter = [CIFilter filterWithName:kCIColorInvert];
        self.inputImage = nil;
    }
    
    return self;
}

- (void)setInputImage:(UIImage *)inputImage {
    [_filter setValue:inputImage.CIImage forKey:kCIInputImageKey];
    _inputImage = inputImage;
}

- (CIImage*)outputImage {
    NSAssert(self.inputImage != nil, @"Filter requires an input image");
    
    return _filter.outputImage;
}

@end
