//
//  APSharpenLuminanceFilter.m
//  APFiltering
//
//  Created by Alin Petrus on 10/30/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APSharpenLuminanceFilter.h"

@implementation APSharpenLuminanceFilter

@synthesize inputSharpness = _inputSharpness;

- (id)init {
    self = [super init];
    
    if (self) {
        _filter = [CIFilter filterWithName:kCISharpenLuminance];
        _inputSharpness = nil;
    }
    
    return self;
}

- (void)setInputSharpness:(NSNumber *)inputSharpness {
    [_filter setValue:inputSharpness forKey:kInputSharpness];
    _inputSharpness = inputSharpness;
}

- (CIImage*)outputImage {
    NSAssert(_inputSharpness != nil, @"Filter requires inputSharpness");
    
    return [super outputImage];
}

@end
