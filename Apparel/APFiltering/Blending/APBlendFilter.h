//
//  APBlendFilter.h
//  APFiltering
//
//  Created by Alin Petrus on 10/29/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APFilter.h"

typedef enum APBlendFilterType {
    APBlendFilterTypeInvalid        = -1,
    APBlendFilterTypeColorBlendMode,
    APBlendFilterTypeBurnBlendMode,
    APBlendFilterTypeColorDodgeBlendMode,
    APBlendFilterTypeDarkenBlendMode,
    APBlendFilterTypeDifferenceBlendMode,
    APBlendFilterTypeExclusionBlendMode,
    APBlendFilterTypeHardLightBlendMode,
    APBlendFilterTypeHueBlendMode,
    APBlendFilterTypeLightenBlendMode,
    APBlendFilterTypeLuminosityBlendMode,
    APBlendFilterTypeOverlayBlendMode,
    APBlendFilterTypeSaturationBlendMode,
    APBlendFilterTypeSoftLightBlendMode
}APBlendFilterType;

@interface APBlendFilter : APFilter

@property (nonatomic, strong) UIImage *inputBackgroundImage;
@property (nonatomic, strong) UIImage *inputImage;

- (id)initWithBlendFilterType:(APBlendFilterType)type;

@end
