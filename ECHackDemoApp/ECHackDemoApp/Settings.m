//
//  Settings.m
//  Wagr
//
//  Copyright © Microsoft. All rights reserved.
//

#import "Settings.h"

static unsigned int hourlyWage; //in cents
static NSString *workerName = @"John Doe";
static NSString *workerEmail = @"john@contoso.com";
static NSString *workerPhone = @"(123)456-7890";

@implementation Settings

+ (unsigned int)hourlyWage {
    return hourlyWage;
}

+ (void)setHourlyWage:(unsigned int)wage {
    hourlyWage = wage;
}

+ (NSString *)workerName {
    return workerName;
}

+ (void)setWorkerName:(NSString *)name {
    workerName = name;
}

+ (NSString *)workerEmail {
    return workerEmail;
}

+ (void)setWorkerEmail:(NSString *)email {
    workerEmail = email;
}

+ (NSString *)workerPhone {
    return workerPhone;
}

+ (void)setWorkerPhone:(NSString *)phone {
    workerPhone = phone;
}


@end
