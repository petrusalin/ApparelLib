//
//  APGloomFilter.m
//  APFiltering
//
//  Created by Alin Petrus on 10/30/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APGloomFilter.h"

@implementation APGloomFilter

@synthesize inputIntesity = _inputIntesity;

- (id)init {
    self = [super init];
    
    if (self) {
        _filter = [CIFilter filterWithName:kCIGloom];
        _inputIntesity = nil;
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
