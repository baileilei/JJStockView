//
//  XMGSessionManager.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/2.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGSessionManager.h"

@implementation XMGSessionManager

- (void)request:(RequestType)requestType urlStr: (NSString *)urlStr parameter: (NSDictionary *)param resultBlock: (void(^)(id responseObject, NSError *error))resultBlock {

    NSLog(@"urlStr----%@",urlStr);
    void(^successBlock)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        resultBlock(responseObject, nil);
    };

    void(^failBlock)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        resultBlock(nil, error);
    };

    if (requestType == RequestTypeGet) {
        [self GET:urlStr parameters:param progress:nil success:successBlock failure:failBlock];
    }else {
        [self POST:urlStr parameters:param progress:nil success:successBlock failure:failBlock];
    }


}


@end
