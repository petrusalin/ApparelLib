//
//  APTwirlDistortionFilter.m
//  APFiltering
//
//  Created by Alin Petrus on 10/30/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APTwirlDistortionFilter.h"

@implementation APTwirlDistortionFilter

@synthesize inputAngle = _inputAngle;

- (id)init {
    self = [super init];
    
    if (self) {
        _filter = [CIFilter filterWithName:kCITwirlDistortion];
        _inputAngle = nil;
    }
    
    return self;
}

- (void)setInputAngle:(NSNumber *)inputAngle {
    [_filter setValue:inputAngle forKey:kInputAngle];
    _inputAngle = inputAngle;
}

- (CIImage*)outputImage {
    NSAssert(_inputAngle != nil, @"Filter requires inputAngle");
    
    return [super outputImage];
}

@end
