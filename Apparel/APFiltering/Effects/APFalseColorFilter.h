//
//  APFalseColorFilter.h
//  APFiltering
//
//  Created by Alin Petrus on 10/30/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APColorInvertFilter.h"

@interface APFalseColorFilter : APColorInvertFilter

@property (nonatomic, strong) UIColor *inputColor0;
@property (nonatomic, strong) UIColor *inputColor1;

@end
