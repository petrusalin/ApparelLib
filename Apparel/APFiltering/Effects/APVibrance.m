//
//  APVibrance.m
//  APFiltering
//
//  Created by Alin Petrus on 10/29/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APVibrance.h"

@implementation APVibrance

@synthesize inputAmmount = _inputAmmount;

- (id)init {
    self = [super init];
    
    if (self) {
        _filter = [CIFilter filterWithName:kCIVibrance];
        self.inputAmmount = nil;
    }
    
    return self;
}

- (void)setInputAmmount:(NSNumber *)inputAmmount {
    [_filter setValue:_inputAmmount forKey:kInputAmount];
    _inputAmmount = inputAmmount;
}

- (CIImage*)outputImage {
    NSAssert(self.inputAmmount != nil, @"Filter requires input ammount");
    
    return [super outputImage];
}

@end
