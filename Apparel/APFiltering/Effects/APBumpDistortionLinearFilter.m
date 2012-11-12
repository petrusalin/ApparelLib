//
//  APBumpDistortionLinearFilter.m
//  APFiltering
//
//  Created by Alin Petrus on 10/30/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APBumpDistortionLinearFilter.h"

@implementation APBumpDistortionLinearFilter

@synthesize inputCenter = _inputCenter;

- (id)init {
    self = [super init];
    
    if (self) {
        _filter = [CIFilter filterWithName:kCIBumpDistortionLinear];
        _inputCenter = CGPointZero;
    }
    
    return self;
}

- (void)setInputCenter:(CGPoint)inputCenter {
    [_filter setValue:[[CIVector alloc] initWithCGPoint:inputCenter] forKey:kInputCenter];
    _inputCenter = inputCenter;
}

@end
