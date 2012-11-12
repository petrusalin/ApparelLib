//
//  APCropFilter.h
//  APFiltering
//
//  Created by Alin Petrus on 10/30/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APColorInvertFilter.h"

@interface APCropFilter : APColorInvertFilter

@property (nonatomic, assign) CGRect inputRectangle;

@end
