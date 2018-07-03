//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IntuneMAMBaseLogger : NSObject

- (id) initWithBundleName:(NSString*)bundleName
                 filePath:(NSString*)logFilePath
                 messagePrefix:(NSString*)messagePrefix;

- (NSString*)getLogFilePath;

// Note: message must not contain PII data
- (void) logError:(NSString*)message;
- (void) logInfo:(NSString*)message;
- (void) logWarning:(NSString*)message;

// Note: message may contain PII data
- (void) logVerbose:(NSString*)message;

@end
