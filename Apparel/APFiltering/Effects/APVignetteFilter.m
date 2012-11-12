//
//  APVignetteFilter.m
//  APFiltering
//
//  Created by Alin Petrus on 10/30/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APVignetteFilter.h"

@implementation APVignetteFilter

- (id)init {
    self = [super init];
    
    if (self) {
        _filter = [CIFilter filterWithName:kCIVignette];
    }
    
    return self;
}

@end
