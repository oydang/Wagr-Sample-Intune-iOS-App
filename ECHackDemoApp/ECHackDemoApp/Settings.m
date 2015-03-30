//
//  Settings.m
//  ECHackDemoApp
//
//  Created by Mac MDM on 3/30/15.
//  Copyright (c) 2015 Microsoft. All rights reserved.
//

#import "Settings.h"

@implementation Settings

static Settings *sharedHourlyWage = nil;

+ (Settings *)sharedHourlyWage {
    if (sharedHourlyWage == nil) {
        sharedHourlyWage = [[super allocWithZone:NULL] init];
    }
    return sharedHourlyWage;
}

- (id)init {
    if ( (self = [super init]) ) {
        // your custom initialization
    }
    return self;
}

@end
