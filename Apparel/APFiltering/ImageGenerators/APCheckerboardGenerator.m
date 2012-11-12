//
//  APCheckerboardGenerator.m
//  APFiltering
//
//  Created by Alin Petrus on 10/30/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APCheckerboardGenerator.h"

@implementation APCheckerboardGenerator

@synthesize inputCenter = _inputCenter;
@synthesize inputColor0 = _inputColor0;
@synthesize inputColor1 = _inputColor1;
@synthesize inputSharpness = _inputSharpness;
@synthesize inputWidth = _inputWidth;

- (id)init {
    self = [super init];
    
    if (self) {
        _filter = [CIFilter filterWithName:kCICheckerboardGenerator];
        _inputCenter = CGPointZero;
        _inputColor0 = nil;
        _inputColor1 = nil;
        _inputSharpness = nil;
        _inputWidth = nil;
    }
    
    return self;
}

- (void)setInputCenter:(CGPoint)inputCenter {
    [_filter setValue:[[CIVector alloc] initWithCGPoint:inputCenter] forKey:kInputCenter];
    _inputCenter = inputCenter;
}

- (void)setInputColor0:(UIColor *)inputColor0 {
    [_filter setValue:[[CIColor alloc] initWithColor:inputColor0] forKey:kInputColor0];
    _inputColor0 = inputColor0;
}

- (void)setInputColor1:(UIColor *)inputColor1 {
    [_filter setValue:[[CIColor alloc] initWithColor:inputColor1] forKey:kInputColor1];
}

- (void)setInputSharpness:(NSNumber *)inputSharpness {
    [_filter setValue:inputSharpness forKey:kInputSharpness];
    _inputSharpness = inputSharpness;
}

- (void)setInputWidth:(NSNumber *)inputWidth {
    [_filter setValue:inputWidth forKey:kInputWidth];
    _inputWidth = inputWidth;
}

- (CIImage*)image {
    NSAssert(_inputColor0 != nil && _inputColor1 != nil, @"Filter requires two inputColors");
    NSAssert(_inputSharpness != 0, @"Filter requires inputSharpness");
    NSAssert(_inputWidth, @"Filter requires inputWidth");
    
    return [super outputImage];
}

@end
