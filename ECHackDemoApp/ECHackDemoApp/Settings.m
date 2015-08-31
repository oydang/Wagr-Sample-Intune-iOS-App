//
//  Settings.m
//  Wagr
//
//  Copyright (c) 2015 Microsoft. All rights reserved.
//

#import "Settings.h"

static int hourlyWage;

@implementation Settings
+(int)hourlyWage {return hourlyWage;}

+(void)setHourlyWage: (int) wage{
    hourlyWage = wage;
}

@end
