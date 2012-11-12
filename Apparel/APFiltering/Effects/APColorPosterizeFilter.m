//
//  APColorPosterizeFilter.m
//  APFiltering
//
//  Created by Alin Petrus on 10/29/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APColorPosterizeFilter.h"

@implementation APColorPosterizeFilter

@synthesize inputLevels = _inputLevels;

- (id)init {
    self = [super init];
    
    if (self) {
        _filter = [CIFilter filterWithName:kCIColorPosterize];
        _inputLevels = nil;
    }
    
    return self;
}

- (void)setInputLevels:(NSNumber *)inputLevels {
    [_filter setValue:inputLevels forKey:kInputLevels];
    _inputLevels = inputLevels;
}

- (CIImage*)outputImage {
    NSAssert(_inputLevels != nil, @"Filter requires inputLevels");
    
    return [super outputImage];
}

@end
