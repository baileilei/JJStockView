//
//  SMLoginNetwork.m
//  smartWiFi
//
//  Created by Smart Wi-Fi on 2019/8/13.
//  Copyright © 2019 Smart Wi-Fi. All rights reserved.
//

#import "SMLoginNetwork.h"
#import "SMUserInfo.h"
#import "SMLoginManage.h"

@implementation SMLoginNetwork

+ (instancetype)shareNetTools {
    static SMLoginNetwork *loginNet = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loginNet = [[self alloc] init];
    });
    return loginNet;
}

+ (void)loginWithAccount:(NSString *)account
                password:(NSString *)pwd
           completeBlock:(void (^)(SMLoginNetwork *conn,id responsed))block
{
    SMLoginNetwork *loginNet = [SMLoginNetwork shareNetTools];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:account,@"username", pwd,@"password", nil];
    NSLog(@"params:%@", params);
    [loginNet doPost:RequestLogin paramters:params completeBlock:^(NSURLSessionDataTask *task, id response) {
        
        if (response) {
            NSLog(@"%@", response);
            //解析获取的json数据
        }
        
        if (block) {
            block(loginNet, response);
        }
    }];
}

+ (void)logoutWithUserId:(NSString *)userId
           completeBlock:(void (^)(SMLoginNetwork *conn,id responsed))block
{
    SMLoginNetwork *loginNet = [SMLoginNetwork shareNetTools];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:userId,@"userId", nil];
    [loginNet doPost:RequestLogout paramters:params completeBlock:^(NSURLSessionDataTask *task, id response) {
        
        if (response) {
            NSLog(@"%@", response);
            //解析获取的json数据
        }
        
        if (block) {
            block(loginNet, response);
        }
    }];
}

+ (void)logoutWithCompleteBlock:(void (^)(SMLoginNetwork *conn,id responsed))block
{
    SMLoginNetwork *loginNet = [SMLoginNetwork shareNetTools];
    
    [loginNet.manager.requestSerializer setValue:[[SMLoginManage sharedManager] getCurrentToken] forHTTPHeaderField:@"Authorization"];
    
    [loginNet doGet:RequestLogout paramters:nil completeBlock:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull response) {
        if (response) {
            NSLog(@"%@", response);
            //解析获取的json数据
        }
        
        if (block) {
            block(loginNet, response);
        }
    }];
}

+ (void)deleteToken:(NSString *)token
      completeBlock:(void (^)(SMLoginNetwork *conn,id responsed))block
{
    SMLoginNetwork *loginNet = [SMLoginNetwork shareNetTools];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:token,@"token", nil];
    [loginNet doPost:RequestDeleteToken paramters:params completeBlock:^(NSURLSessionDataTask *task, id response) {
        
        if (response) {
            NSLog(@"%@", response);
            //解析获取的json数据
        }
        
        if (block) {
            block(loginNet, response);
        }
    }];
}

@end
