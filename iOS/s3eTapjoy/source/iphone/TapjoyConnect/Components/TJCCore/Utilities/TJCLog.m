//
//  TJCLog.m
//  TapjoyConnectionClinet
//
//  Created by Tapjoy.
//  Copyright 2010 Tapjoy.com All rights reserved.


#import "TJCLog.h"

//#warning change to LOG_NONFATAL_ERROR for production builds vs. LOG_ALL...
static int _logThreshold =  LOG_NONFATAL_ERROR;

@implementation TJCLog
#pragma mark -
#pragma mark Class Methods

+ (void) setLogThreshold: (int) myThreshhold;
{
    _logThreshold = myThreshhold;
}

+ (void) logWithLevel: (int) myLevel format: (NSString *) myFormat, ...;
{
    va_list s;
    NSString * localFormat = nil;
	
    if (myLevel > _logThreshold) {
        return;
    }
	
    localFormat = [NSString stringWithFormat: @"[Log Level: %d]; %@\n", myLevel, myFormat];
    
    va_start(s, myFormat);
    NSLogv(localFormat, s);
    va_end(s);
}

@end
