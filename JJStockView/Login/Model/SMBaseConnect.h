//
//  SMBaseConnect.h
//  smartWiFi
//
//  Created by Smart Wi-Fi on 2019/8/13.
//  Copyright © 2019 Smart Wi-Fi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

NS_ASSUME_NONNULL_BEGIN

#define kTimeOutInterval    15.0
#define DTServerIp          [SMBaseConnect getSeverIPWithKey:@"SMK_ServerIP"]

extern NSString *const RequestLogin;
extern NSString *const RequestLogout;
extern NSString *const RequestDeleteToken;
extern NSString *const RequestDownloadUrl;

@interface SMBaseConnect : NSObject

@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, assign) BOOL success;
@property (nonatomic, assign) NSInteger resultCode; //错误码
@property (nonatomic, copy) NSString *resultMsg;

//获取相应访问域名
+ (NSString *)getSeverIPWithKey:(NSString *)key;

//检查网络
+ (BOOL)checkNetWorkStatus;

//POST测试
- (void)doTestPost:(NSString *)url
         paramters:(nullable NSDictionary *)paramters
     completeBlock:(void (^)(NSURLSessionDataTask *task, id response))block;

//POST请求
- (void)doPost:(NSString *)url
     paramters:(nullable NSDictionary *)parmaters
 completeBlock:(void (^)(NSURLSessionDataTask *task, id response))block;

//POST上传文件
- (void)doFilePost:(NSString *)url
          paramter:(nullable NSDictionary *)parmater
          filePath:(NSURL *)filePath
     completeBlock:(void (^)(NSURLSessionDataTask *task, id response))block;

//GET请求
- (void)doGet:(NSString *)url
    paramters:(nullable NSDictionary *)paramters
completeBlock:(void (^)(NSURLSessionDataTask *task, id response))block;

@end

NS_ASSUME_NONNULL_END
