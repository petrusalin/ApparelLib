//
//  APGloomFilter.h
//  APFiltering
//
//  Created by Alin Petrus on 10/30/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APGaussianBlurFilter.h"

@interface APGloomFilter : APGaussianBlurFilter

@property (nonatomic, strong) NSNumber *inputIntesity;

@end
