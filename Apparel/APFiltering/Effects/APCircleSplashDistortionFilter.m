//
//  APCircleSplashDistortionFilter.m
//  APFiltering
//
//  Created by Alin Petrus on 10/30/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APCircleSplashDistortionFilter.h"

@implementation APCircleSplashDistortionFilter

@synthesize inputCenter = _inputCenter;

- (id)init {
    self = [super init];
    
    if (self) {
        _filter = [CIFilter filterWithName:kCICircleSplashDistortion];
        _inputCenter = CGPointZero;
    }
    
    return self;
}

- (void)setInputCenter:(CGPoint)inputCenter {
    [_filter setValue:[CIVector vectorWithCGPoint:inputCenter] forKey:kInputCenter];
    _inputCenter = inputCenter;
}

@end
