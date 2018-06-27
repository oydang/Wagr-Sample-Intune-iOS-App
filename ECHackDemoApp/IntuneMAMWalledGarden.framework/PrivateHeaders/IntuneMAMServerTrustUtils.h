//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

// A root-first array of public keys representing a trusted cert chain
typedef NSArray<NSData*> IntuneMAMServerTrustChain;

@interface IntuneMAMServerTrustUtils : NSObject

// Returns YES iff challenge has authenticationMethod NSURLAuthenticationMethodServerTrust and
// the server cert is a leaf of a chain in trustChains
+(BOOL) isTrustedService:(NSURLAuthenticationChallenge*)challenge trustChains:(NSArray<IntuneMAMServerTrustChain*>*)trustChains;

// Returns YES iff challenge has authenticationMethod NSURLAuthenticationMethodServerTrust and
// the server cert is trusted under a built-in trust policy for certain Microsoft services that are deployed in either public or sovereign clouds. Server trust is different for public and sovereign clouds, therefore "identity" helps determine which server certs to use for a the given user
+(BOOL) isTrustedMicrosoftService:(NSURLAuthenticationChallenge*)challenge identity:(NSString*)identity;

@end
