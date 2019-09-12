//
//  HWNetTools.m
//  JsInterface
//
//  Created by smart-wift on 2019/6/12.
//  Copyright © 2019 ganwenpeng.com. All rights reserved.
//

#import "HWNetTools.h"
#import "HMTHintView.h"


@implementation HWNetTools

static HWNetTools *instance;

static NSString *nstrPublicUrl = @"https://w3m.huawei.com/mcloud/umag/fg/FreeProxyForText/smartwifi_test";

+(instancetype)shareNetTools{
    
    if (!instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            instance = [[self alloc] init];
            instance.requestSerializer = [AFJSONRequestSerializer serializer];
            [instance.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

            
            instance.requestSerializer.timeoutInterval = 10;
            
            
            NSMutableSet *acceptableContentTypes = [NSMutableSet setWithSet:instance.responseSerializer.acceptableContentTypes];
            [acceptableContentTypes addObjectsFromArray:@[@"application/json", @"text/json", @"text/javascript",@"text/html",@"plant/html",@"text/plain",@"text/xml"]];
            instance.responseSerializer.acceptableContentTypes = acceptableContentTypes;
        });
    }
    
    return instance;
}


#pragma mark - 自定义GET
//
- (void)requestGET:(NSString *)URLString parames:(id)parames success:(void (^)(id responseObj))success failure:(void (^)(id error))failure{
    //AFN没有做UTF8转码 防止URL字符串中含有中文或特殊字符发生崩溃
    URLString = [[NSString  stringWithFormat:@"%@/%@",nstrPublicUrl,URLString]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     NSLog(@"URLString =%@ params = %@",URLString, parames);
    [self GET:URLString parameters:parames success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code == -1009 || error.code == -1005 || error.code == -1003 || error.code == -1004 || error.code == -1001) {
            [HMTHintView alertWithView:nil message:error.userInfo[NSLocalizedDescriptionKey]];
        }
        failure(error);
    }];
    
}

#pragma mark - 自定义POST

- (void)requestPOST:(NSString *)URLString parames:(id)parames success:(void (^)(id responseObj))success failure:(void (^)(id error))failure{
    //AFN没有做UTF8转码 防止URL字符串中含有中文或特殊字符 发生崩溃
    URLString = [[NSString stringWithFormat:@"%@/%@",nstrPublicUrl,URLString]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"URLString =%@ params = %@",URLString, parames);
    [self POST:URLString parameters:parames success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        ////将接收回来的数据转成UTF8的字符串，然后取出格式占位符 加上个转义符后才能让数据进行转换 否则转换失败
        //        NSString*jsonString = [[NSString alloc] initWithBytes:[responseObject bytes]length:[responseObject length]encoding:NSUTF8StringEncoding];
        //        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\t" withString:@"\\t"];
        //        NSData * jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"responseObject---%@",responseObject);
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error-NSLocalizedDescription---%@",error);
        failure(@{@"error":error.userInfo[NSLocalizedDescriptionKey],@"code":@(error.code)});
    }];
}

@end
