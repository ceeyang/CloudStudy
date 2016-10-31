//
//  DESUtils.m
//  PRJ_base64
//
//  Created by zhiminglantai on 14-4-30.
//  Copyright (c) 2014年 com.comsoft. All rights reserved.
//

#import "DESUtils.h"

@implementation DESUtils

+(NSString *)decryptUseDES:(NSString *)cipherText key:(NSString *)key
{
    NSString *plaintext = nil;
    
    NSData *cipherdata =[NSData dataFromBase64String:cipherText]; //[Base64 decode:];
    
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String], kCCKeySizeDES,
                                          (Byte *)[[key dataUsingEncoding:NSUTF8StringEncoding] bytes],
                                          [cipherdata bytes], [cipherdata length],
                                          buffer, 1024,
                                          &numBytesDecrypted);
    if(cryptStatus == kCCSuccess) {
        NSData *plaindata = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plaintext = [[NSString alloc]initWithData:plaindata encoding:NSUTF8StringEncoding];
    }
    return plaintext;
}
+(NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key
{
    
    static Byte iv[] = {1,2,3,4,5,6,7,8};
    
    NSString *ciphertext = nil;
    NSData *textData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [textData length];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
//    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
//                                          kCCOptionPKCS7Padding,
//                                          [key UTF8String], kCCKeySizeDES,
//                                          (Byte *)[[key dataUsingEncoding:NSUTF8StringEncoding] bytes],
//                                          [textData bytes], dataLength,
//                                          buffer, 1024,
//                                          &numBytesEncrypted);
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,kCCOptionPKCS7Padding,[key UTF8String], kCCKeySizeDES,iv,[textData bytes], dataLength,buffer, 1024,&numBytesEncrypted);
    
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        
        ciphertext =[data base64EncodedString];  // [Base64  :data];
    }
    return ciphertext;
}

@end
