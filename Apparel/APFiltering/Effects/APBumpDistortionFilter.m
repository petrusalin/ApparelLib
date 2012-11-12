//
//  APBumpDistortionFilter.m
//  APFiltering
//
//  Created by Alin Petrus on 10/30/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APBumpDistortionFilter.h"

@implementation APBumpDistortionFilter

@synthesize inputScale = _inputScale;

- (id)init {
    self = [super init];
    
    if (self) {
        _filter = [CIFilter filterWithName:kCIBumpDistortion];
        _inputScale = nil;
    }
    
    return self;
}

- (void)setInputScale:(NSNumber *)inputScale {
    [_filter setValue:inputScale forKey:kInputScale];
    _inputScale = inputScale;
}

- (CIImage*)outputImage {
    NSAssert(_inputScale != nil, @"Filter requires inputScale");
    
    return [super outputImage];
}

@end
