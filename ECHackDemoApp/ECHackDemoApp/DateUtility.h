//
//  DateUtility.h
//  Wagr
//
//  Copyright © Microsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtility : NSObject

+ (unsigned int)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime;

@end
