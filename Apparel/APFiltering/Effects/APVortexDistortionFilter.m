//
//  APVortexDistortion.m
//  APFiltering
//
//  Created by Alin Petrus on 10/30/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APVortexDistortionFilter.h"

@implementation APVortexDistortionFilter

- (id)init {
    self = [super init];
    
    if (self) {
        _filter = [CIFilter filterWithName:kCIVortexDistortion];
    }
    
    return self;
}

@end
