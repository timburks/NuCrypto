;; test_rsa.nu
;;  tests for Nu RSA wrapper.
;;
;;  Copyright (c) 2010 Tim Burks, Radtastical, Inc.

(load "NuCrypto")

(class TestRSA is NuTestCase
     
     (- testPublicEncryptionPrivateDecryption is
        (set k1 ((NuRSAKey alloc) init))
        (set k2 ((NuRSAKey alloc) initWithDictionary:(k1 dictionaryRepresentation)))
        (set encrypted (k1 encryptDataWithPublicKey:("hello" dataUsingEncoding:NSUTF8StringEncoding)))
        (set decrypted (k2 decryptDataWithPrivateKey:encrypted))
        (assert_equal "hello" (NSString stringWithData:decrypted encoding:NSUTF8StringEncoding)))
     
     (- testPrivateEncryptionPublicDecryption is
        (set k1 ((NuRSAKey alloc) init))
        (set k2 ((NuRSAKey alloc) initWithDictionary:(k1 dictionaryRepresentation)))
        (set encrypted (k1 encryptDataWithPrivateKey:("hello" dataUsingEncoding:NSUTF8StringEncoding)))
        (set decrypted (k2 decryptDataWithPublicKey:encrypted))
        (assert_equal "hello" (NSString stringWithData:decrypted encoding:NSUTF8StringEncoding))))