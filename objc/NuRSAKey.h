/*!
 @file NuRSAKey.h
 @copyright Copyright (c) 2010 Radtastical, Inc.
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import <Foundation/Foundation.h>

#include <openssl/err.h>
#include <openssl/ssl.h>

@interface NuRSAKey : NSObject
{
    RSA *key;
}

- (id) init;
- (id) initWithModulus:(NSString *) modulus exponent:(NSString *) exponent;
- (id) initWithDictionary:(NSDictionary *) dictionary;
- (int) maxSize;
- (NSString *) modulus;
- (NSString *) exponent;
- (NSDictionary *) dictionaryRepresentation;
- (NSDictionary *) publicKeyDictionaryRepresentation;
- (NSData *) encryptDataWithPublicKey:(NSData *) data;
- (NSData *) encryptDataWithPrivateKey:(NSData *) data;
- (NSData *) decryptDataWithPublicKey:(NSData *) data;
- (NSData *) decryptDataWithPrivateKey:(NSData *) data;

@end