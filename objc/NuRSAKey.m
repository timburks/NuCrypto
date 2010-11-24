/*!
 @file NuRSAKey.m
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

#import "NuRSAKey.h"
#import "NuBinaryEncoding.h"

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <openssl/err.h>
#include <openssl/ssl.h>

@implementation NuRSAKey

- (id) init
{
    if (self = [super init]) {
        key = RSA_generate_key(1024, RSA_F4, NULL, NULL);
    }
    return self;
}

- (id) initWithModulus:(NSString *) modulus exponent:(NSString *) exponent
{
    if (self = [super init]) {
        key = RSA_new();
        if (modulus) {
            BN_hex2bn(&(key->n), [modulus cStringUsingEncoding:NSUTF8StringEncoding]);
        }
        if (exponent) {
            BN_hex2bn(&(key->e), [exponent cStringUsingEncoding:NSUTF8StringEncoding]);
        }
    }
    return self;
}

static NSString *string_for_object(id object)
{
    if ([object isKindOfClass:[NSData class]]) {
        NSString *string = [object hexEncodedString];
        return string;
    }
    else if ([object isKindOfClass:[NSString class]]) {
        return object;
    }
    else {
        return nil;
    }
}

- (id) initWithDictionary:(NSDictionary *) dictionary
{
    if (self = [super init]) {
        key = RSA_new();
        id n,e,d,p,q;
        if ((n = [dictionary objectForKey:@"n"])) {
            n = string_for_object(n);
            BN_hex2bn(&(key->n), [n cStringUsingEncoding:NSUTF8StringEncoding]);
        }
        if ((e = [dictionary objectForKey:@"e"])) {
            e = string_for_object(e);
            BN_hex2bn(&(key->e), [e cStringUsingEncoding:NSUTF8StringEncoding]);
        }
        if ((d = [dictionary objectForKey:@"d"])) {
            d = string_for_object(d);
            BN_hex2bn(&(key->d), [d cStringUsingEncoding:NSUTF8StringEncoding]);
        }
        if ((p = [dictionary objectForKey:@"p"])) {
            p = string_for_object(p);
            BN_hex2bn(&(key->p), [p cStringUsingEncoding:NSUTF8StringEncoding]);
        }
        if ((q = [dictionary objectForKey:@"q"])) {
            q = string_for_object(q);
            BN_hex2bn(&(key->q), [q cStringUsingEncoding:NSUTF8StringEncoding]);
        }
    }
    return self;
}

- (int) maxSize
{
    return RSA_size(key);
}

- (int) check
{
	return RSA_check_key(key);
}

- (NSString *) modulus
{
    return [NSString stringWithCString:BN_bn2hex(key->n) encoding:NSUTF8StringEncoding];
}

- (NSString *) exponent
{
    return [NSString stringWithCString:BN_bn2hex(key->e) encoding:NSUTF8StringEncoding];
}

static NSData *data(NSString *string)
{
    return [NSData dataWithHexEncodedString:string];
}

- (NSDictionary *) dictionaryRepresentation
{
    NSMutableDictionary *representation = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           data([NSString stringWithCString:BN_bn2hex(key->n) encoding:NSUTF8StringEncoding]), @"n",
                                           data([NSString stringWithCString:BN_bn2hex(key->e) encoding:NSUTF8StringEncoding]), @"e",
                                           nil];
    if (key->d) {
        [representation setObject:data([NSString stringWithCString:BN_bn2hex(key->d) encoding:NSUTF8StringEncoding])
                           forKey:@"d"];
    }
    if (key->p) {
        [representation setObject:data([NSString stringWithCString:BN_bn2hex(key->p) encoding:NSUTF8StringEncoding])
                           forKey:@"p"];
    }
    if (key->q) {
        [representation setObject:data([NSString stringWithCString:BN_bn2hex(key->q) encoding:NSUTF8StringEncoding])
                           forKey:@"q"];
    }
    return representation;
}

- (NSDictionary *) publicKeyDictionaryRepresentation
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            data([NSString stringWithCString:BN_bn2hex(key->n) encoding:NSUTF8StringEncoding]), @"n",
            data([NSString stringWithCString:BN_bn2hex(key->e) encoding:NSUTF8StringEncoding]), @"e",
            nil];
}

- (NSData *) encryptDataWithPublicKey:(NSData *) data
{
    int maxSize = RSA_size(key);
    unsigned char *output = (unsigned char *) malloc(maxSize * sizeof(char));
    int bytes = RSA_public_encrypt([data length], [data bytes], output, key, RSA_PKCS1_PADDING);
	return (bytes > 0) ? [NSData dataWithBytes:output length:bytes] : nil;
}

- (NSData *) encryptDataWithPrivateKey:(NSData *) data
{
    int maxSize = RSA_size(key);
    unsigned char *output = (unsigned char *) malloc(maxSize * sizeof(char));
    int bytes = RSA_private_encrypt([data length], [data bytes], output, key, RSA_PKCS1_PADDING);
    return (bytes > 0) ? [NSData dataWithBytes:output length:bytes] : nil;
}

- (NSData *) decryptDataWithPublicKey:(NSData *) data
{
    int maxSize = RSA_size(key);
    unsigned char *output = (unsigned char *) malloc(maxSize * sizeof(char));
    int bytes = RSA_public_decrypt([data length], [data bytes], output, key, RSA_PKCS1_PADDING);
    return (bytes > 0) ? [NSData dataWithBytes:output length:bytes] : nil;
}

- (NSData *) decryptDataWithPrivateKey:(NSData *) data
{
    int maxSize = RSA_size(key);
    unsigned char *output = (unsigned char *) malloc(maxSize * sizeof(char));
    int bytes = RSA_private_decrypt([data length], [data bytes], output, key, RSA_PKCS1_PADDING);
	return (bytes > 0) ? [NSData dataWithBytes:output length:bytes] : nil;
}

@end
