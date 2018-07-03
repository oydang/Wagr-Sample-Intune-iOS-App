//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IntuneMAMServiceLocator : NSObject

// Registers a singleton instance of a given service.
+ (void) registerService:(Protocol*)protocol service:(id)service;

// Registers a class of a given service. A new object is returned for each call to service().
+ (void) registerService:(Protocol*)protocol class:(Class)class;

// Returns the service given the specified protocol.
+ (id) service:(Protocol*)protocol;

@end
