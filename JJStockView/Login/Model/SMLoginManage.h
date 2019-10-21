//
//  SMLoginManage.h
//  smartWiFi
//
//  Created by Smart Wi-Fi on 2019/8/13.
//  Copyright © 2019 Smart Wi-Fi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMUserInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface SMLoginManage : NSObject

@property (nonatomic, strong) SMUserInfo *userInfo;

+ (instancetype)sharedManager;

- (BOOL)isLogin;

- (void)LogoutCurrentUserInfo;

- (void)saveCurrentUserInfo:(SMUserInfo *)userInfo;
- (SMUserInfo *)getCurrentUserInfo;

- (NSString *)getCurrentUserAccount;
- (NSString *)getCurrentUserId;
- (NSString *)getCurrentToken;

//校验ip
+ (BOOL)isIp:(NSString *)ipStr;

//校验域名
+ (BOOL)isUrlAddress:(NSString*)url;
@end

NS_ASSUME_NONNULL_END
