//
//  APExposureAdjustFilter.m
//  APFiltering
//
//  Created by Alin Petrus on 10/29/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APExposureAdjustFilter.h"

@implementation APExposureAdjustFilter

@synthesize inputEV = _inputEV;

- (id)init {
    self = [super init];
    
    if (self) {
        _inputEV = nil;
        _filter = [CIFilter filterWithName:kCIExposureAdjust];
    }
    
    return self;
}

- (void)setInputEV:(NSNumber *)inputEV {
    [_filter setValue:inputEV forKey:kInputEV];
    _inputEV = inputEV;
}

- (CIImage*)outputImage {
    NSAssert(_inputEV != nil, @"Filter requires inputEV");
    
    return [super outputImage];
}

@end
