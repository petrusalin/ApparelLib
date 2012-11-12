//
//  APRandomGenerator.m
//  APFiltering
//
//  Created by Alin Petrus on 10/30/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APRandomGenerator.h"

@implementation APRandomGenerator

- (id)init {
    self = [super init];
    
    if (self) {
        _filter = [CIFilter filterWithName:kCIColorInvert];
    }
    
    return self;
}

@end
