#import <Foundation/Foundation.h>

typedef struct rsa_st RSA; 

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