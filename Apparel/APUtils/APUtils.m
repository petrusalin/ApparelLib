//
//  APUtils.m
//  APNoticeView
//
//  Created by Alin Petrus on 9/14/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APUtils.h"

@implementation APUtils

+ (NSString*)fullBundlePath:(NSString*)bundlePath{
	return [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:bundlePath];
}

@end
