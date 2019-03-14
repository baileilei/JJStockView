//
//  XMGSessionManager.h
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/2.
//  Copyright © 2016年 小码哥. All rights reserved.
//该分类是针对AFN一层的封装。

#import "AFNetworking.h"

typedef enum{
    RequestTypeGet,
    RequestTypePost

}RequestType;


@interface XMGSessionManager : AFHTTPSessionManager

- (void)request:(RequestType)requestType urlStr: (NSString *)urlStr parameter: (NSDictionary *)param resultBlock: (void(^)(id responseObject, NSError *error))resultBlock;

@end
