//
//  DateUtility.h
//  ECHackDemoApp
//
//  Created by Joe on 3/31/15.
//  Copyright (c) 2015 Microsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtility : NSObject

+(int)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime;

@end