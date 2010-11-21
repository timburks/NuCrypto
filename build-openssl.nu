#!/usr/local/bin/nush
;;
;; Build fat static iOS libraries for OpenSSL.
;;
;; This script follows instructions presented at
;; http://www.x2on.de/2010/07/13/tutorial-iphone-app-with-compiled-openssl-1-0-0a-library/
;;
;; Run this script in a directory that contains an openssl tarfile. 
;; 
;; It creates a corresponding openssl source directory and a platforms
;; directory containing platform-specific builds. On successful completion, 
;; platforms/iOS will contain fat library binaries for libcrypto.a and libssl.a
;;
(set VERSION "openssl-1.0.0b")
(set SDK "4.2")
(set PLATFORMS (dict i386:"iPhoneSimulator"
                     armv6:"iPhoneOS"
                     armv7:"iPhoneOS"))
(set ARCHITECTURES ((PLATFORMS allKeys) sort))
(set CWD (NSString stringWithShellCommand:"pwd"))

;; remove any pre-existing directories
(system "rm -rf #{VERSION} platforms")

;; extract archive
(system "tar xvf #{VERSION}.tar")

;; patch source file to fix compiler error
(set filename (+ VERSION "/crypto/ui/ui_openssl.c"))
(set original (NSString stringWithContentsOfFile:filename))
(set patched
     (original stringByReplacingOccurrencesOfString:"static volatile sig_atomic_t intr_signal;"
          withString:"static volatile int intr_signal;"))
(patched writeToFile:filename atomically:YES)

;; build OpenSSL libraries for each architecture
(ARCHITECTURES each:
     (do (arch)
         (set platform (PLATFORMS arch))
         
         ;; configure
         (system "cd #{VERSION}; ./configure BSD-generic32 --openssldir=#{CWD}/platforms/#{arch}")
         
         ;; platform-specific Makefile patches
         (set s (NSString stringWithContentsOfFile:(+ VERSION "/Makefile")))
         (set s (s stringByReplacingOccurrencesOfString:"CC= gcc"
                   withString:"CC= /Developer/Platforms/#{platform}.platform/Developer/usr/bin/gcc -arch #{arch}"))
         (set s (s stringByReplacingOccurrencesOfString:"CFLAG= "
                   withString:"CFLAG= -isysroot /Developer/Platforms/#{platform}.platform/Developer/SDKs/#{platform}#{SDK}.sdk "))
         (s writeToFile:(+ VERSION "/Makefile") atomically:NO)
         
         ;; make
         (system "cd #{VERSION}; make; make install; make clean")))

;; make fat static libraries
(system "mkdir -pv platforms/iOS")

('("libcrypto.a" "libssl.a") each:
  (do (target)
      (set command (+ "lipo "
                      ((ARCHITECTURES map:(do (arch) (+ "platforms/" arch "/lib/" target))) componentsJoinedByString:" ")
                      " -create -output platforms/iOS/" target))
      (puts command)
      (system command)))