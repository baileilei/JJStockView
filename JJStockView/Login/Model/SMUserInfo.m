//
//  SMUserInfo.m
//  smartWiFi
//
//  Created by Smart Wi-Fi on 2019/8/16.
//  Copyright © 2019 Smart Wi-Fi. All rights reserved.
//

#import "SMUserInfo.h"

@implementation SMUserInfo

+ (SMUserInfo *)userInfoWithObject:(id)object
{
    if (object == nil) {
        return nil;
    }
    SMUserInfo *userInfo = [[SMUserInfo alloc] init];
    userInfo.userName = object[@"data"][@"userInfo"][@"account"];;
    userInfo.userId = object[@"data"][@"userInfo"][@"id"];
    userInfo.token = object[@"data"][@"csrfToken"];
    
    return userInfo;
}

@end
