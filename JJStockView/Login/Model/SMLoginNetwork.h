//
//  SMLoginNetwork.h
//  smartWiFi
//
//  Created by Smart Wi-Fi on 2019/8/13.
//  Copyright © 2019 Smart Wi-Fi. All rights reserved.
//

#import "SMBaseConnect.h"

NS_ASSUME_NONNULL_BEGIN

@interface SMLoginNetwork : SMBaseConnect

+ (instancetype)shareNetTools;

//登录账号
+ (void)loginWithAccount:(nonnull NSString *)account
                      password:(nonnull NSString *)pwd
                 completeBlock:(void (^)(SMLoginNetwork *conn,id responsed))block;

//登出账号
+ (void)logoutWithUserId:(nonnull NSString *)userId
           completeBlock:(void (^)(SMLoginNetwork *conn,id responsed))block;

+ (void)logoutWithCompleteBlock:(void (^)(SMLoginNetwork *conn,id responsed))block;

//删除token
+ (void)deleteToken:(nonnull NSString *)token
           completeBlock:(void (^)(SMLoginNetwork *conn,id responsed))block;

@end

NS_ASSUME_NONNULL_END
