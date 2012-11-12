//
//  APHueAdjust.m
//  APFiltering
//
//  Created by Alin Petrus on 10/29/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APHueAdjust.h"

@implementation APHueAdjust

@synthesize inputAngle = _inputAngle;

- (id)init {
    self = [super init];
    
    if (self) {
        _filter = [CIFilter filterWithName:kCIHueAdjust];
        self.inputAngle = nil;
    }
    
    return self;
}

- (void)setInputAngle:(NSNumber *)inputAngle {
    [_filter setValue:inputAngle forKey:kInputAngle];
    _inputAngle = inputAngle;
}

- (CIImage*)outputImage {
    NSAssert(_inputAngle != nil, @"Filter requires input angle");
    
    return [super outputImage];
}

@end
