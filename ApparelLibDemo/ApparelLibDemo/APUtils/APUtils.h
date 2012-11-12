//
//  APUtils.h
//  APNoticeView
//
//  Created by Alin Petrus on 9/14/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APUtils : NSObject

#define APBUNDLE(_URL) [APUtils fullBundlePath:_URL]

#define APLog(s, ...) NSLog( @"[%@ %@] %@",NSStringFromClass([self class]), NSStringFromSelector(_cmd),[NSString stringWithFormat:(s), ##__VA_ARGS__] )

+ (NSString*)fullBundlePath:(NSString*)bundlePath;

@end
