//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IntuneMAMWalledGarden/IntuneMAMPolicyManager.h>

@interface IntuneMAMBrowserPolicyManager : NSObject

+ (IntuneMAMBrowserPolicyManager*) instance;

// Returns an array of allowed browser host names as NSString*(s). The array can be empty if no URLs are allowed. Nil if it is not set.
// The values can have * wildcards.
// If a value does not start with http:// or https:// then both should be allowed. The values may end in /*,
// but it is not required.
// e.g. http://www.contoso.com, *.contoso.com, https://*.contoso.com, https://*.contoso.com/*
@property (readonly) NSArray* allowedURLs;

// Returns an array of disallowed browser host names as NSString*(s). The array can be empty if no URLs are disallowed. Nil if it is not set.
// The values can have * wildcards.
// If a value does not start with http:// or https:// then both should be disallowed. The values may end in /*,
// but it is not required.
// e.g. http://www.contoso.com, *.contoso.com, https://*.contoso.com, https://*.contoso.com/*
@property (readonly) NSArray* deniedURLs;

@end
