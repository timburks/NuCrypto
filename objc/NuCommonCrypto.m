/*!
 @file NuCommonCrypto.m
 @copyright Copyright (c) 2011 Radtastical, Inc.

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
#import <CommonCrypto/CommonCryptor.h>

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

- (NSMutableData*) aesEncryptWithKey:(NSString *) key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero( keyPtr, sizeof(keyPtr) );

    [key getCString: keyPtr maxLength: sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    size_t numBytesEncrypted = 0;

    NSUInteger dataLength = [self length];

    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);

    NSMutableData *output = [[NSData alloc] init];

    CCCryptorStatus result = CCCrypt( kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
        keyPtr, kCCKeySizeAES256,
        NULL,
        [self bytes], [self length],
        buffer, bufferSize,
        &numBytesEncrypted );

    output = [NSMutableData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    if( result == kCCSuccess ) {
        return output;
    }
    return NULL;
}

- (NSMutableData*) aesDecryptWithKey:(NSString *) key 
{
    char  keyPtr[kCCKeySizeAES256+1];
    bzero( keyPtr, sizeof(keyPtr) );

    [key getCString: keyPtr maxLength: sizeof(keyPtr) encoding:NSUTF8StringEncoding];

    size_t numBytesEncrypted = 0;

    NSUInteger dataLength = [self length];

    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer_decrypt = malloc(bufferSize);
    NSMutableData *output_decrypt = [[NSData alloc] init];
    CCCryptorStatus result = CCCrypt( kCCDecrypt , kCCAlgorithmAES128, kCCOptionPKCS7Padding,
        keyPtr, kCCKeySizeAES256,
        NULL,
        [self bytes], [self length],
        buffer_decrypt, bufferSize,
        &numBytesEncrypted );

    output_decrypt = [NSMutableData dataWithBytesNoCopy:buffer_decrypt length:numBytesEncrypted];
    if( result == kCCSuccess ) {
        return output_decrypt;
    }
    return NULL;
}

@end
