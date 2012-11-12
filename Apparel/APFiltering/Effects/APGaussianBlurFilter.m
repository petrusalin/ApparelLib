//
//  APGaussianBlurFilter.m
//  APFiltering
//
//  Created by Alin Petrus on 10/29/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APGaussianBlurFilter.h"

@implementation APGaussianBlurFilter

@synthesize inputRadius = _inputRadius;

- (id)init {
    self = [super init];
    
    if (self) {
        _filter = [CIFilter filterWithName:kCIGaussianBlur];
        _inputRadius = nil;
    }
    
    return self;
}

- (void)setInputRadius:(NSNumber *)inputRadius {
    [_filter setValue:inputRadius forKey:kInputRadius];
    _inputRadius = inputRadius;
}

- (CIImage*)outputImage {
    NSAssert(_inputRadius != nil, @"Filter requires inputRadius");
    
    return [super outputImage];
}

@end
