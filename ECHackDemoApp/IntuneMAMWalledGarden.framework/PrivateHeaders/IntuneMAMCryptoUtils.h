//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IntuneMAMCryptoUtils : NSObject

// Returns a MD5 hash of the specified string.
+ (NSString*) md5Hash:(NSString*)data;

@end
