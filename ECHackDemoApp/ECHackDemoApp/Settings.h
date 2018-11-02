//
//  Settings.h
//  Wagr
//
//  Copyright © Microsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Settings : NSObject

+ (unsigned int)hourlyWage;

+ (void)setHourlyWage:(unsigned int)wage;

+ (NSString *)workerName;

+ (void)setWorkerName:(NSString *)name;

+ (NSString *)workerEmail;

+ (void)setWorkerEmail:(NSString *)email;

+ (NSString *)workerPhone;

+ (void)setWorkerPhone:(NSString *)phone;

@end
