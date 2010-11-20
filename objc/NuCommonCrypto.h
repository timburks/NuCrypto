/*!
 @file NuCommonCrypto.h
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

@interface NSData (NuCommonCrypto)
- (NSData *) md5Data;
- (NSData *) sha1Data;
- (NSData *) sha224Data;
- (NSData *) sha256Data;
- (NSData *) sha384Data;
- (NSData *) sha512Data;
- (NSData *) hmacMd5DataWithKey:(NSData *) key;
- (NSData *) hmacSha1DataWithKey:(NSData *) key;
- (NSData *) hmacSha224DataWithKey:(NSData *) key;
- (NSData *) hmacSha256DataWithKey:(NSData *) key;
- (NSData *) hmacSha384DataWithKey:(NSData *) key;
- (NSData *) hmacSha512DataWithKey:(NSData *) key;
@end