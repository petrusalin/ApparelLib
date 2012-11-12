//
//  APStraightenFilter.m
//  APFiltering
//
//  Created by Alin Petrus on 10/29/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APStraightenFilter.h"

@implementation APStraightenFilter

- (id)init {
    self = [super init];
    
    if (self) {
        _filter = [CIFilter filterWithName:kCIStraightenFilter];
    }
    
    return self;
}

@end
