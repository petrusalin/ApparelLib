//
//  APFalseColorFilter.m
//  APFiltering
//
//  Created by Alin Petrus on 10/30/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APFalseColorFilter.h"

@implementation APFalseColorFilter

@synthesize inputColor0 = _inputColor0;
@synthesize inputColor1 = _inputColor1;

- (id)init {
    self = [super init];
    
    if (self) {
        _filter = [CIFilter filterWithName:kCIFalseColor];
        _inputColor0 = nil;
        _inputColor1 = nil;
    }
    
    return self;
}

- (void)setInputColor0:(UIColor *)inputColor0 {
    [_filter setValue:[[CIColor alloc] initWithColor:inputColor0] forKey:kInputColor0];
    _inputColor0 = inputColor0;
}

- (void)setInputColor1:(UIColor *)inputColor1 {
    [_filter setValue:[[CIColor alloc] initWithColor:inputColor1] forKey:kInputColor1];
    _inputColor1 = inputColor1;
}

- (CIImage*)outputImage {
    NSAssert(_inputColor0 != nil && _inputColor1 != nil, @"Filter requires two input Colors");
    
    return [super outputImage];
}

@end
