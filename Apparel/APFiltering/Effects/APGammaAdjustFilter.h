//
//  APCIGammaAdjustFilter.h
//  APFiltering
//
//  Created by Alin Petrus on 10/29/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APColorInvertFilter.h"

@interface APGammaAdjustFilter : APColorInvertFilter

@property (nonatomic, strong) NSNumber *inputPower;

@end
