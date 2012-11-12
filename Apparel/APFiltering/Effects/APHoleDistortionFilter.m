//
//  APHoleDistortionFilter.m
//  APFiltering
//
//  Created by Alin Petrus on 10/29/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APHoleDistortionFilter.h"

@implementation APHoleDistortionFilter

- (id)init {
    self = [super init];
    
    if (self) {
        _filter = [CIFilter filterWithName:kCIHoleDistortion];
    }
    
    return self;
}

@end
