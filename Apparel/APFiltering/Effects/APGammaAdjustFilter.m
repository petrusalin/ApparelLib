//
//  APCIGammaAdjustFilter.m
//  APFiltering
//
//  Created by Alin Petrus on 10/29/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APGammaAdjustFilter.h"

@implementation APGammaAdjustFilter

@synthesize inputPower = _inputPower;

- (id)init {
    self = [super init];
    
    if (self) {
        _filter = [CIFilter filterWithName:kCIGammaAdjust];
        _inputPower = nil;
    }
    
    return self;
}

- (void)setInputPower:(NSNumber *)inputPower {
    [_filter setValue:inputPower forKey:kInputPower];
    _inputPower = inputPower;
}

- (CIImage*)outputImage {
    NSAssert(_inputPower != nil, @"Filter requires inputPower");
    
    return [super outputImage];
}

@end
