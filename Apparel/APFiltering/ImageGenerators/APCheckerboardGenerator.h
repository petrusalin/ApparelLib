//
//  APCheckerboardGenerator.h
//  APFiltering
//
//  Created by Alin Petrus on 10/30/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APRandomGenerator.h"

@interface APCheckerboardGenerator : APRandomGenerator

@property (nonatomic, assign) CGPoint inputCenter;
@property (nonatomic, strong) UIColor *inputColor0;
@property (nonatomic, strong) UIColor *inputColor1;
@property (nonatomic, strong) NSNumber *inputSharpness;
@property (nonatomic, strong) NSNumber *inputWidth;

@end
