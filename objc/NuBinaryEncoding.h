#import <Foundation/Foundation.h>

@interface NSData (NuBinaryEncoding)
- (NSString *) hexEncodedString;
+ (id) dataWithHexEncodedString:(NSString *) string;
- (NSString *) base64EncodedString;
+ (id) dataWithBase64EncodedString:(NSString *) string;
@end
