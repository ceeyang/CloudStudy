//
//  DESUtils.h
//  PRJ_base64
//
//  Created by zhiminglantai on 14-4-30.
//  Copyright (c) 2014年 com.comsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>
#import "NSData+Base64.h"
@interface DESUtils : NSObject
+(NSString *)decryptUseDES:(NSString *)cipherText key:(NSString *)key;
+(NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key;
@end
