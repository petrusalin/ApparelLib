//
//  APUnsharpMaskFilter.m
//  APFiltering
//
//  Created by Alin Petrus on 10/30/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APUnsharpMaskFilter.h"

@implementation APUnsharpMaskFilter

- (id)init {
    self = [super init];
    
    if (self)  {
        _filter = [CIFilter filterWithName:kCIUnsharpMask];
    }
    
    return self;
}

@end
