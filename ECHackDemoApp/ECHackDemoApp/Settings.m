//
//  Settings.m
//  ECHackDemoApp
//
//  Created by Mac MDM on 3/30/15.
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
