//
//  Settings.m
//  Wagr
//
//  Copyright (c) Microsoft. All rights reserved.
//

#import "Settings.h"

static unsigned int hourlyWage;

@implementation Settings
+ (unsigned int)hourlyWage { return hourlyWage; }

+ (void)setHourlyWage:(unsigned int)wage
{
    hourlyWage = wage;
}

@end
