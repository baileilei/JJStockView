//
//  SMUserInfo.h
//  smartWiFi
//
//  Created by Smart Wi-Fi on 2019/8/16.
//  Copyright © 2019 Smart Wi-Fi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMUserInfo : NSObject

// 用户名
@property (nonatomic, copy) NSString *userName;
// 密码
@property (nonatomic, copy) NSString *userPwd;
// 用户id
@property (nonatomic, copy) NSString *userId;
// 登录token
@property (nonatomic, copy) NSString *token;

+ (SMUserInfo *)userInfoWithObject:(id)object;

@end

NS_ASSUME_NONNULL_END
