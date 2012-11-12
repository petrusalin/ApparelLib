//
//  APExposureAdjustFilter.h
//  APFiltering
//
//  Created by Alin Petrus on 10/29/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APColorInvertFilter.h"

@interface APExposureAdjustFilter : APColorInvertFilter

@property (nonatomic, strong) NSNumber *inputEV;

@end
