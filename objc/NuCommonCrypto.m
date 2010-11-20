/*!
 @file NuCommonCrypto.m
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

#import "NuCommonCrypto.h"
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonDigest.h>

@implementation NSData (NuCommonCrypto)

- (NSData *) md5Data
{
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5([self bytes], [self length], result);
    return [NSData dataWithBytes:result length:CC_MD5_DIGEST_LENGTH];
}

- (NSData *) sha1Data
{
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1([self bytes], [self length], result);
    return [NSData dataWithBytes:result length:CC_SHA1_DIGEST_LENGTH];
}

- (NSData *) sha224Data
{
    unsigned char result[CC_SHA224_DIGEST_LENGTH];
    CC_SHA224([self bytes], [self length], result);
    return [NSData dataWithBytes:result length:CC_SHA224_DIGEST_LENGTH];
}

- (NSData *) sha256Data
{
    unsigned char result[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256([self bytes], [self length], result);
    return [NSData dataWithBytes:result length:CC_SHA256_DIGEST_LENGTH];
}

- (NSData *) sha384Data
{
    unsigned char result[CC_SHA384_DIGEST_LENGTH];
    CC_SHA384([self bytes], [self length], result);
    return [NSData dataWithBytes:result length:CC_SHA384_DIGEST_LENGTH];
}

- (NSData *) sha512Data
{
    unsigned char result[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512([self bytes], [self length], result);
    return [NSData dataWithBytes:result length:CC_SHA512_DIGEST_LENGTH];
}

- (NSData *) hmacMd5DataWithKey:(NSData *) key
{
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgMD5, [key bytes], [key length], [self bytes], [self length], result);
    return [NSData dataWithBytes:result length:CC_MD5_DIGEST_LENGTH];
}

- (NSData *) hmacSha1DataWithKey:(NSData *) key
{
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, [key bytes], [key length], [self bytes], [self length], result);
    return [NSData dataWithBytes:result length:CC_SHA1_DIGEST_LENGTH];
}

- (NSData *) hmacSha224DataWithKey:(NSData *) key
{
    unsigned char result[CC_SHA224_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA224, [key bytes], [key length], [self bytes], [self length], result);
    return [NSData dataWithBytes:result length:CC_SHA224_DIGEST_LENGTH];
}

- (NSData *) hmacSha256DataWithKey:(NSData *) key
{
    unsigned char result[CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, [key bytes], [key length], [self bytes], [self length], result);
    return [NSData dataWithBytes:result length:CC_SHA256_DIGEST_LENGTH];
}

- (NSData *) hmacSha384DataWithKey:(NSData *) key
{
    unsigned char result[CC_SHA384_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA384, [key bytes], [key length], [self bytes], [self length], result);
    return [NSData dataWithBytes:result length:CC_SHA384_DIGEST_LENGTH];
}

- (NSData *) hmacSha512DataWithKey:(NSData *) key
{
    unsigned char result[CC_SHA512_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA512, [key bytes], [key length], [self bytes], [self length], result);
    return [NSData dataWithBytes:result length:CC_SHA512_DIGEST_LENGTH];
}

@end
