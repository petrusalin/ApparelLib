//
//  APBloomFilter.m
//  APFiltering
//
//  Created by Alin Petrus on 10/29/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APBloomFilter.h"

@implementation APBloomFilter

@synthesize inputIntesity = _inputIntesity;

- (id)init {
    self = [super init];
    
    if (self) {
        _inputIntesity = nil;
        _filter = [CIFilter filterWithName:kCIBloom];
    }
    
    return self;
}

- (void)setInputIntesity:(NSNumber *)inputIntesity {
    [_filter setValue:inputIntesity forKey:kInputIntensity];
    _inputIntesity = inputIntesity;
}

- (CIImage*)outputImage {
    NSAssert(_inputIntesity != nil, @"Filter requires inputIntensity");
    
    return [super outputImage];
}

@end
