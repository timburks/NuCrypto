;; test_aes.nu
;;  tests for Nu AES wrapper.
;;
;;  Copyright (c) 2011 Tim Burks, Radtastical, Inc.

(load "NuCrypto")

(class TestAES is NuTestCase
     
     (- testAES is
        (set message "Bonjour tout le monde, je voudrais vous présenter la Société Futur")
        (set key "E4704524-038B-47D7-8705-4EE07A3EAED8")        
        (set messageData (message dataUsingEncoding:NSUTF8StringEncoding))
        (set encryptedData (messageData aesEncryptWithKey:key))
        (set decryptedData (encryptedData aesDecryptWithKey:key))
        (set decrypted (NSString stringWithData:decryptedData encoding:NSUTF8StringEncoding))
        (assert_equal decrypted message)
        (set decryptedData (encryptedData aesDecryptWithKey:"wrongkey"))
        (set decrypted (NSString stringWithData:decryptedData encoding:NSUTF8StringEncoding))
        (assert_not_equal decrypted message)))