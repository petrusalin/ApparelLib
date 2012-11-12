//
//  APBumpDistortionFilter.h
//  APFiltering
//
//  Created by Alin Petrus on 10/30/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APGaussianBlurFilter.h"

@interface APBumpDistortionFilter : APGaussianBlurFilter

@property (nonatomic, strong) NSNumber *inputScale;

@end
