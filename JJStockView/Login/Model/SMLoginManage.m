//
//  SMLoginManage.m
//  smartWiFi
//
//  Created by Smart Wi-Fi on 2019/8/13.
//  Copyright © 2019 Smart Wi-Fi. All rights reserved.
//

#import "SMLoginManage.h"
#import "NSString+AES.h"

#define SMK_CurrentLoginState   @"SMK_CurrentLoginState"

#define SMK_UserInfoAccount     @"SMK_UserInfoAccount"
#define SMK_UserInfoPassword    @"SMK_UserInfoPassword"
#define SMK_UserInfoId          @"SMK_UserInfoId"
#define SMK_UserInfoToken       @"SMK_UserInfoToken"

@implementation SMLoginManage

+ (instancetype)sharedManager {
    static SMLoginManage *loginManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loginManager = [[self alloc] init];
    });
    return loginManager;
}

- (BOOL)isLogin {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    BOOL loginState = [userDefault boolForKey:SMK_CurrentLoginState];
    return loginState;
}

- (void)LogoutCurrentUserInfo {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    [userDefault removeObjectForKey:SMK_UserInfoPassword];
    [userDefault removeObjectForKey:SMK_UserInfoId];
    [userDefault removeObjectForKey:SMK_UserInfoToken];
    
    //保存登出状态
    [userDefault setBool:NO forKey:SMK_CurrentLoginState];
    [userDefault synchronize];
    
    [userDefault synchronize];
}

- (void)saveCurrentUserInfo:(SMUserInfo *)userInfo {
    if (userInfo == nil) {
        return;
    }
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    NSString *userName = [userInfo.userName sm_encryptWithAES_CBC];
    [userDefault setObject:userName forKey:SMK_UserInfoAccount];
    NSString *userId = [userInfo.userId sm_encryptWithAES_CBC];
    [userDefault setObject:userId forKey:SMK_UserInfoId];
    NSString *token = [userInfo.token sm_encryptWithAES_CBC];
    [userDefault setObject:token forKey:SMK_UserInfoToken];
    
    //保存登录状态
    [userDefault setBool:YES forKey:SMK_CurrentLoginState];
    [userDefault synchronize];
}

- (SMUserInfo *)getCurrentUserInfo {
    SMUserInfo *userInfo = [[SMUserInfo alloc] init];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    userInfo.userName = [[userDefault objectForKey:SMK_UserInfoAccount] sm_decryptWithAES_CBC];
    userInfo.userPwd = [[userDefault objectForKey:SMK_UserInfoPassword] sm_decryptWithAES_CBC];
    userInfo.userId = [[userDefault objectForKey:SMK_UserInfoId] sm_decryptWithAES_CBC];
    userInfo.token = [[userDefault objectForKey:SMK_UserInfoToken] sm_decryptWithAES_CBC];
    
    return userInfo;
}

- (NSString *)getCurrentUserAccount {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *userName = [[userDefault objectForKey:SMK_UserInfoAccount] sm_decryptWithAES_CBC];
    
    return userName;
}

- (NSString *)getCurrentUserId {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *userId = [[userDefault objectForKey:SMK_UserInfoId] sm_decryptWithAES_CBC];
    
    return userId;
}

- (NSString *)getCurrentToken {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *userName = [[userDefault objectForKey:SMK_UserInfoToken] sm_decryptWithAES_CBC];
    
    return userName;
}

//校验ip
/*
 "^(1\\d{2}|2[0-4]\\d|25[0-5]|[1-9]\\d|[1-9])\\.(1\\d{2}|2[0-4]\\d|25[0-5]|[1-9]\\d|\\d)\\.(1\\d{2}|2[0-4]\\d|25[0-5]|[1-9]\\d|\\d)\\.(1\\d{2}|2[0-4]\\d|25[0-5]|[1-9]\\d|\\d)$"
 
 ^(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])$
 */
+ (BOOL)isIp:(NSString *)ipStr
{
    NSString *ipRegex = @"^(1\\d{2}|2[0-4]\\d|25[0-5]|[1-9]\\d|[1-9])\\.(1\\d{2}|2[0-4]\\d|25[0-5]|[1-9]\\d|\\d)\\.(1\\d{2}|2[0-4]\\d|25[0-5]|[1-9]\\d|\\d)\\.(1\\d{2}|2[0-4]\\d|25[0-5]|[1-9]\\d|\\d)$";
    NSPredicate *ipTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ipRegex];
    BOOL isMatch = [ipTest evaluateWithObject:ipStr];
    return isMatch;
}

//校验域名
/*-----网址
 [a-zA-z]+://[^\s]*

 ^((https|http|ftp|rtsp|mms)?://)"
 + "?(([0-9a-z_!~*'().&=+$%-]+: )?[0-9a-z_!~*'().&=+$%-]+@)?" //ftp的user@
 + "(([0-9]{1,3}\\.){3}[0-9]{1,3}" // IP形式的URL- 199.194.52.184
 + "|" // 允许IP和DOMAIN（域名）
 + "([0-9a-z_!~*'()-]+\\.)*" // 域名- www.
 + "([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\\." // 二级域名
 + "[a-z]{2,6})" // first level domain- .com or .museum
 + "(:[0-9]{1,4})?" // 端口- :80
 + "((/?)|" // a slash isn't required if there is no file name
 + "(/[0-9a-z_!~*'().;?:@&=+$,%#-]+)+/?)$
 
 ^((https|http|ftp|rtsp|mms)?://)?(([0-9a-z_!~*'().&=+$%-]+: )?[0-9a-z_!~*'().&=+$%-]+@)?(([0-9]{1,3}\\.){3}[0-9]{1,3}|([0-9a-z_!~*'()-]+\\.)*([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\\.[a-z]{2,6})(:[0-9]{1,4})?((/?)|(/[0-9a-z_!~*'().;?:@&=+$,%#-]+)+/?)$
 
 ([a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|([a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|((2[0-4]\\d|25[0-5]|[01]?\\d\\d?)\\.){3}(2[0-4]\\d|25[0-5]|[01]?\\d\\d?)|(((2[0-4]\\d|25[0-5]|[01]?\\d\\d?)\\.){3}(2[0-4]\\d|25[0-5]|[01]?\\d\\d?))
 */
+ (BOOL)isUrlAddress:(NSString*)url
{// -----域名：
    NSString*reg =@"^((https|http|ftp|rtsp|mms)?://)?(([0-9a-z_!~*'().&=+$%-]+: )?[0-9a-z_!~*'().&=+$%-]+@)?(([0-9]{1,3}\\.){3}[0-9]{1,3}|([0-9a-z_!~*'()-]+\\.)*([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\\.[a-z]{2,6})(:[0-9]{1,4})?((/?)|(/[0-9a-z_!~*'().;?:@&=+$,%#-]+)+/?)$";
    NSPredicate *urlPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg];
    return[urlPredicate evaluateWithObject:url.lowercaseString];
    
}

@end
