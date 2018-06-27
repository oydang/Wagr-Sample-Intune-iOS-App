//
//  Copyright (c) 2014 Microsoft Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IntuneMAMEncryptionProvider : NSObject

- (id) initWithPublicKeyTag:(NSString *)publicKeyTag PrivateKeyTag:(NSString *)privateKeyTag AccessGroup:(NSString *)accessGroup;

- (NSMutableData *)encryptDataWithPublicKey:(NSData *)dataToEncrypt;
- (NSData *)decryptDataWithPrivateKey: (NSData *)dataToDecrypt;

-(SecKeyRef) getPublicKey;
-(SecKeyRef) getPrivateKey;

+ (OSStatus) deleteKey:(NSString *)tag AccessGroup:(NSString *)accessGroup;


@end
