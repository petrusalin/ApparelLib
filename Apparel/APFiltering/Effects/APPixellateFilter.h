//
//  APPixellateFilter.h
//  APFiltering
//
//  Created by Alin Petrus on 10/30/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APColorInvertFilter.h"

@interface APPixellateFilter : APColorInvertFilter

@property (nonatomic, strong) NSNumber *inputScale;
@property (nonatomic, assign) CGPoint inputCenter;

@end
