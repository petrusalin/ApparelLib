//
//  APColorMonochromeFilter.m
//  APFiltering
//
//  Created by Alin Petrus on 10/29/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APColorMonochromeFilter.h"

@implementation APColorMonochromeFilter

@synthesize inputColor = _inputColor;

- (id)init {
    self = [super init];
    
    if (self) {
        _filter = [CIFilter filterWithName:kCIColorMonochrome];
        _inputColor = nil;
    }
    
    return self;
}

- (void)setInputColor:(UIColor *)inputColor {
    [_filter setValue:[[CIColor alloc] initWithColor:inputColor] forKey:kInputColor];
    _inputColor = inputColor;
}

- (CIImage*)outputImage {
    NSAssert(_inputColor != nil, @"Filter requires input color");
    
    return [super outputImage];
}

@end
