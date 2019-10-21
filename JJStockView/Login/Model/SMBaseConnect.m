//
//  SMBaseConnect.m
//  smartWiFi
//
//  Created by Smart Wi-Fi on 2019/8/13.
//  Copyright © 2019 Smart Wi-Fi. All rights reserved.
//

#import "SMBaseConnect.h"

NSString *const RequestLogin = @"smartwifi-user-manage/login";
NSString *const RequestLogout = @"smartwifi-user-manage/userLogout";
NSString *const RequestDeleteToken = @"smartwifi-user-manage/deleteToken";
NSString *const RequestDownloadUrl = @"smartwifi-lite-app/appVersion/getDownloadUrl";

@interface SMBaseConnect()

@end

@implementation SMBaseConnect

#pragma mark - 初始配置
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setHeader];
    }
    return self;
}

//请求配置
- (void)setHeader
{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.timeoutIntervalForRequest = kTimeOutInterval;
    self.manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:config];

    // 声明上传的数据格式
    _manager.requestSerializer = [AFJSONRequestSerializer serializer]; //上传JSON格式

    // 声明获取到的数据格式
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    
//    [_manager setSecurityPolicy:[self customSecurityPolicy]];
    
}

- (AFSecurityPolicy *)customSecurityPolicy {
    // 先导入证书 证书由服务端生成，具体由服务端人员操作
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"tls" ofType:@"cer"];//证书的路径
    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    securityPolicy.pinnedCertificates = [[NSSet alloc] initWithObjects:cerData,nil];
    
    return securityPolicy;
    
}

#pragma mark - interface
//获取相应访问域名
+ (NSString *)getSeverIPWithKey:(NSString *)key
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SMK_CustomList" ofType:@"plist"];
    NSDictionary *keyDict = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSLog(@"path = %@,%@", path,keyDict);
    
    if (keyDict) {
        if ([key isEqualToString:@"SMK_ServerIP"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"IPAddress"]) {
            return [[NSUserDefaults standardUserDefaults] objectForKey:@"IPAddress"];
        } else {
            return [keyDict objectForKey:key];
        }
    }
    return @"";
}

+ (BOOL)checkNetWorkStatus {
    /**
     *  AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     *  AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     *  AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G
     *  AFNetworkReachabilityStatusReachableViaWiFi = 2,   // 局域网络Wifi
     */
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    if ([[AFNetworkReachabilityManager sharedManager]networkReachabilityStatus] == AFNetworkReachabilityStatusNotReachable) {
        return NO;
    }
    else return YES;
}

//----------------------------------------------------------------------------

- (void)doTestPost:(NSString *)url
         paramters:(NSDictionary *)paramters
     completeBlock:(void (^)(NSURLSessionDataTask *task, id response))block
{
    [_manager POST:url parameters:paramters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handelResponseSuccess:task responseObject:responseObject completeBlock:block];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handelResponseError:task error:error completeBlock:block];
    }];
    
}

- (void)doPost:(NSString *)url
     paramters:(NSDictionary *)paramters
 completeBlock:(void (^)(NSURLSessionDataTask *task, id response))block
{
    NSString *URL = [NSString stringWithFormat:@"%@/%@",DTServerIp,url];
    NSLog(@"POST:%@", URL);
    
    [_manager POST:URL parameters:paramters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handelResponseSuccess:task responseObject:responseObject completeBlock:block];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handelResponseError:task error:error completeBlock:block];
    }];
    
}

- (void)doFilePost:(NSString *)url
          paramter:(NSDictionary *)paramters
          filePath:(NSURL *)filePath
     completeBlock:(void (^)(NSURLSessionDataTask *task, id response))block
{
    NSString *URL = [NSString stringWithFormat:@"%@/%@",DTServerIp,url];
    
    [_manager POST:URL parameters:paramters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileURL:filePath name:@"file" error:nil];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handelResponseSuccess:task responseObject:responseObject completeBlock:block];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handelResponseError:task error:error completeBlock:block];
    }];
    
}

- (void)doGet:(NSString *)url
    paramters:(NSDictionary *)paramters
completeBlock:(void (^)(NSURLSessionDataTask *task, id response))block
{
    NSString *URL = [NSString stringWithFormat:@"%@/%@",DTServerIp,url];
    NSLog(@"GET:%@", URL);
    
    [_manager GET:URL parameters:paramters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handelResponseSuccess:task responseObject:responseObject completeBlock:block];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handelResponseError:task error:error completeBlock:block];
    }];
    
}

//----------------------------------------------------------------------------

#pragma mark - Method
//成功处理
- (void)handelResponseSuccess:(NSURLSessionDataTask *)task responseObject:(id)responseObject completeBlock:(void (^)(NSURLSessionDataTask *task, id response))block
{
    NSLog(@"Success Request:%@\n%@", task.currentRequest.URL, responseObject);
    
    if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
        self.success = YES;
        self.resultCode = [[responseObject objectForKey:@"status"] integerValue];
        self.resultMsg = [responseObject objectForKey:@"msg"];
    }
    
    if (block) {
        block(task, responseObject);
    }
    
}

//失败处理
- (void)handelResponseError:(NSURLSessionDataTask *)task error:(NSError *)error completeBlock:(void (^)(NSURLSessionDataTask *task, id response))block
{
    NSLog(@"Error Request:%@\n%@", task.currentRequest.URL, error.description);
    
    self.success = NO;
    self.resultCode = error.code;
    
    //通用异常
    if (error.code == -1009 || error.code == -1003) { //网络异常
//        [HMTHintView alertWithView:[[self class] sm_findCurrentViewController].view message:LocalizedStringForkey(@"ids_tip_noNetworkToCheck")];
        return;
    } else if (error.code == -1001) { //请求超时
//        [HMTHintView alertWithView:[[self class] sm_findCurrentViewController].view message:LocalizedStringForkey(@"ids_tip_networkTimeout")];
        return;
    }
        
    if (block) {
        block(task, error.userInfo[NSLocalizedDescriptionKey]);
    }
}

@end
