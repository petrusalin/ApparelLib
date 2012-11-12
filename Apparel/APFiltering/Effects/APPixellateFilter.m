//
//  APPixellateFilter.m
//  APFiltering
//
//  Created by Alin Petrus on 10/30/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APPixellateFilter.h"

@implementation APPixellateFilter

@synthesize inputScale = _inputScale;
@synthesize inputCenter = _inputCenter;

- (id)init {
    self = [super init];
    
    if (self) {
        _filter = [CIFilter filterWithName:kCIPixellate];
        _inputScale = nil;
        _inputCenter = CGPointZero;
    }
    
    return self;
}

- (void)setInputCenter:(CGPoint)inputCenter {
    [_filter setValue:[[CIVector alloc] initWithCGPoint:inputCenter] forKey:kInputCenter];
    _inputCenter = inputCenter;
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
