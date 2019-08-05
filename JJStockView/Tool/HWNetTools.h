//
//  HWNetTools.h
//  JsInterface
//
//  Created by smart-wift on 2019/6/12.
//  Copyright © 2019 ganwenpeng.com. All rights reserved.
//

#import "AFHTTPSessionManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface HWNetTools : AFHTTPSessionManager

+(instancetype)shareNetTools;

/**
 *  基于AFN二次封装GET方法
 *
 *  @URLString    相对路径
 *  @params       请求参数
 *  @finish      完成回调
 *
 */
- (void)requestGET:(NSString *)URLString parames:(id)parames success:(void (^)(id responseObj))success failure:(void (^)(id error))failure;

/**
 *   基于AFN二次封装POST方法
 *
 *  @URLString    相对路径
 *  @params       请求参数
 *  @finish      完成回调
 */
- (void)requestPOST:(NSString *)URLString parames:(id)parames success:(void (^)(id responseObj))success failure:(void (^)(id error))failure;





@end

NS_ASSUME_NONNULL_END
