//
//  APBlendFilter.m
//  APFiltering
//
//  Created by Alin Petrus on 10/29/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APBlendFilter.h"

@interface APBlendFilter ()
- (NSString*)blendFilterNameForType:(APBlendFilterType)type;
@end

@implementation APBlendFilter

@synthesize inputBackgroundImage = _inputBackgroundImage;
@synthesize inputImage = _inputImage;

#pragma mark -
#pragma mark life cycle

- (id)init {
    return [self initWithBlendFilterType:APBlendFilterTypeHardLightBlendMode];
}

- (id)initWithBlendFilterType:(APBlendFilterType)type {
    self = [super init];
    
    if (self) {
        _filter = [CIFilter filterWithName:[self blendFilterNameForType:type]];
        _inputImage = nil;
        _inputBackgroundImage = nil;
    }
    
    return self;
}

- (void)setInputBackgroundImage:(UIImage *)inputBackgroundImage {
    [_filter setValue:inputBackgroundImage.CIImage forKey:kCIInputBackgroundImageKey];
    _inputBackgroundImage = inputBackgroundImage;
}

- (void)setInputImage:(UIImage *)inputImage {
    [_filter setValue:inputImage.CIImage forKey:kCIInputImageKey];
    _inputImage = inputImage;
}

- (CIImage*)outputImage {
    NSAssert((self.inputImage != nil && self.inputBackgroundImage != nil), @"Blending requires an inputBakgroundImage and an inputImage!");
    
    return _filter.outputImage;
}

#pragma mark -
#pragma mark private

- (NSString*)blendFilterNameForType:(APBlendFilterType)type {
    switch (type) {
        case APBlendFilterTypeColorBlendMode:
            return kCIColorBlendMode;
        case APBlendFilterTypeBurnBlendMode:
            return kCIColorBurnBlendMode;
        case APBlendFilterTypeColorDodgeBlendMode:
            return kCIColorDodgeBlendMode;
        case APBlendFilterTypeDarkenBlendMode:
            return kCIDarkenBlendMode;
        case APBlendFilterTypeDifferenceBlendMode:
            return kCIDifferenceBlendMode;
        case APBlendFilterTypeExclusionBlendMode:
            return kCIExclusionBlendMode;
        case APBlendFilterTypeHardLightBlendMode:
            return kCIHardLightBlendMode;
        case APBlendFilterTypeHueBlendMode:
            return kCIHueBlendMode;
        case APBlendFilterTypeLightenBlendMode:
            return kCILightenBlendMode;
        case APBlendFilterTypeLuminosityBlendMode:
            return kCILuminosityBlendMode;
        case APBlendFilterTypeOverlayBlendMode:
            return kCIOverlayBlendMode;
        case APBlendFilterTypeSaturationBlendMode:
            return kCISaturationBlendMode;
        case APBlendFilterTypeSoftLightBlendMode:
            return kCISoftLightBlendMode;
        default:
            break;
    }
    
    return kCIHardLightBlendMode;
}

@end
