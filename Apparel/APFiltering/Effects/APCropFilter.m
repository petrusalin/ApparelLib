//
//  APCropFilter.m
//  APFiltering
//
//  Created by Alin Petrus on 10/30/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APCropFilter.h"

@implementation APCropFilter

@synthesize inputRectangle = _inputRectangle;

- (id)init {
    self = [super init];
    
    if (self) {
        _filter = [CIFilter filterWithName:kCICrop];
        _inputRectangle = CGRectMake(0, 0, 0, 0);
    }
    
    return self;
}

- (void)setInputRectangle:(CGRect)inputRectangle {
    [_filter setValue:[[CIVector alloc] initWithCGRect:inputRectangle] forKey:kInputRectangle];
    _inputRectangle = _inputRectangle;
}

@end
