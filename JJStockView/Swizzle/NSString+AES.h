//
//  NSString+AES.h
//  smartWiFi
//
//  Created by Smart Wi-Fi on 2019/8/16.
//  Copyright © 2019 Smart Wi-Fi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (AES)

/**< 加密方法 */
- (NSString*)sm_encryptWithAES_CBC;

/**< 解密方法 */
- (NSString*)sm_decryptWithAES_CBC;

@end

NS_ASSUME_NONNULL_END
