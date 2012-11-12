//
//  APCircleSplashDistortionFilter.h
//  APFiltering
//
//  Created by Alin Petrus on 10/30/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APGaussianBlurFilter.h"

@interface APCircleSplashDistortionFilter : APGaussianBlurFilter

@property (nonatomic, assign) CGPoint inputCenter;

@end
