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