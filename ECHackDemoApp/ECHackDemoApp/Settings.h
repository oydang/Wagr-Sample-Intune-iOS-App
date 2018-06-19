//
//  Settings.h
//  Wagr
//
//  Copyright (c) Microsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Settings : NSObject
    
+ (unsigned int)hourlyWage;
+ (void)setHourlyWage:(unsigned int)wage;
@end
