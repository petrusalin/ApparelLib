//
//  APFilter.m
//  APFiltering
//
//  Created by Alin Petrus on 10/29/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APFilter.h"

@implementation APFilter

@synthesize filter = _filter;
@synthesize outputImage = _outputImage;

- (id)init {
    self = [super init];
    
    if (self) {
        _filter = [CIFilter filterWithName:kCIRandomGenerator];
    }
    
    return self;
}

- (CIImage*)outputImage {
    return _filter.outputImage;
}

- (void)setDefaultParameters {
    [_filter setDefaults];
}

- (NSString*)description {
    return [NSString stringWithFormat:@"Filter: %@ %@\nInput parameters: %@", [_filter name], [_filter inputKeys], [_filter description]];
}

@end
